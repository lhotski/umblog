class Post < ApplicationRecord
  belongs_to :user, autosave: true
  has_many :rates

  scope :top, ->(n) { order(average_rate: :desc, created_at: :desc).limit(n) }

  delegate :login, to: :user, prefix: true

  def self.create_with_user!(post_attributes, user_attributes)
    user = User.find_or_initialize_by(login: user_attributes[:login])
    create! post_attributes.merge(user: user)
  end

  def rate!(value)
    transaction do
      self.rates.create! value: value
      update_attribute :average_rate, self.rates.average(:value)
    end
  end
end
