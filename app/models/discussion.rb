# frozen_string_literal: true

class Discussion < ApplicationRecord
  belongs_to :user, default: -> { Current.user }
  belongs_to :category, counter_cache: true, touch: true

  delegate :name, prefix: true, to: :category

  has_many :posts, dependent: :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :posts

  broadcasts_to :category, inserts_by: :prepend
  after_create_commit -> { broadcast_prepend_to 'discussions' }
  after_update_commit -> { broadcast_replace_to 'discussions' }
  after_destroy_commit -> { broadcast_remove_to 'discussions' }

  def to_param
    "#{id}-#{name.downcase.to_s[0...100]}".parameterize
  end
end
