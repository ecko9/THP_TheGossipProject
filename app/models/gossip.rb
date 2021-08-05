class Gossip < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :users, through: :likes
  has_many :comments
  has_many :join_gossip_and_tags
  has_many :tags, through: :join_gossip_and_tags

  validates :title, presence: true, length: { minimum: 3}
  validates :content, presence: true
  validates :user_id, presence: true
end
