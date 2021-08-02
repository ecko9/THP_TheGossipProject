class JoinTagAndGossip < ActiveRecord::Migration[5.2]
  def change
    add_reference :join_gossip_and_tags, :tag, foreign_key: true
    add_reference :join_gossip_and_tags, :gossip, foreign_key: true
  end
end
