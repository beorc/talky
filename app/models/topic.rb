require Talky::Engine.validator_path(:language)

class Topic < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Associations
  has_many :posts, :dependent => :destroy
  belongs_to :forum, :counter_cache => true
  belongs_to :user, :class_name => 'User', :counter_cache => true

  # Accessors
  attr_accessor :body
  attr_accessible :title, :body, :sticky, :locked, :slug

  # Validations
  validates :title,   :presence => true
  validates :body,    :presence => true, :on => :create
  validates :posts,   :presence => true, :allow_nil => false, :on => :update
  validates :user,    :presence => true
  validates :title,   :language => true, if: :language?
  validates :body,    :language => true, if: :language?

  # Scopes
  default_scope :order => 'sticky DESC, updated_at DESC'

  # Callbacks
  after_create :create_initial_post

  # Delegates
  delegate :language, :language?, to: :forum

  # Methods
  def hit!
    self.class.increment_counter :hits, id
  end

  def should_generate_new_friendly_id?
    new_record? && !slug
  end

  private
    def create_initial_post
      self.posts.build(:body => self.body).tap do |post|
        post.forum = self.forum
        post.user = self.user
        post.save
      end
    end
end
