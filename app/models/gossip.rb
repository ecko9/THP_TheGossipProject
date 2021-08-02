class Gossip < ApplicationRecord
  belongs_to :user
  has_many :join_gossip_and_tags
  has_many :tags, through: :join_gossip_and_tags

end
