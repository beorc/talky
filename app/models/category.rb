class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Associations
  has_many :forums, :dependent => :destroy

  # Accessors
  attr_accessible :title, :state, :position, :category_id, :slug

  # Scopes
  default_scope :order => 'position ASC'

  # Validations
  validates :title,       :presence => true

  def should_generate_new_friendly_id?
    new_record? && !slug
  end
end
