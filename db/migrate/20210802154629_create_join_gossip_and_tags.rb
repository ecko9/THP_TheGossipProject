class CreateJoinGossipAndTags < ActiveRecord::Migration[5.2]
  def change
    create_table :join_gossip_and_tags do |t|
      
      t.timestamps
    end
  end
end
