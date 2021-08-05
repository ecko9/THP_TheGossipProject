module GossipHelper

  def current_gossip
    Gossip.find(params[:id])
  end
  
end
