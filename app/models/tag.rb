class Tag < ApplicationRecord
  has_many :join_gossip_and_tags
  has_many :gossips, through: :join_gossip_and_tags
end
