require Talky::Engine.validator_path(:language)

class Post < ActiveRecord::Base

  # Associations
  belongs_to :forum, :counter_cache => true
  belongs_to :topic, :counter_cache => true, :touch => true
  belongs_to :user, :class_name => 'User', :counter_cache => true

  # Accessors
  attr_accessible :body

  # Validations
  validates :body, :user, :topic, :forum, :presence => true
  validates :body, :language => true, if: :language?

  # Default Scope
  default_scope :order => 'created_at ASC'

  # Scope to display only the last n posts. Used for "Recent Posts" display
  scope :recent, lambda {
    |c| reorder('created_at desc').limit(c)
  }

  # Callbacks
  before_save :topic_locked?
  after_save :send_notifications

  # Delegates
  delegate :language, :language?, to: :forum

  # Methods
  private
    def topic_locked?
      if topic.locked?
        errors.add(:base, "That topic is locked")
        false
      end
    end

    def send_notifications
      return if user.admin?
      emails = ::User.admins.map(&:email).compact
      return if emails.empty?

      PostsMailer.delay.send_notification_email(emails, post_url_options: { id: id },
                                                        topic_url_options: { id: topic.id },
                                                        topic: topic.title,
                                                        user: user.title,
                                                        message: body)
    end
end
