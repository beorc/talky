class Forum < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Associations
  has_many :topics, :dependent => :destroy
  has_many :posts, :through => :topics

  belongs_to :category

  # Accessors
  attr_accessible :title, :description, :state, :position, :category_id, :language, :slug

  # Scopes
  default_scope :order => 'position ASC'

  # Validations
  validates :title,       :presence => true
  validates :description, :presence => true
  validates :category_id, :presence => true

  def should_generate_new_friendly_id?
    new_record? && !slug
  end
end
