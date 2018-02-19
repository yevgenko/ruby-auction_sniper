require 'xmpp4r/client'
require 'faye/websocket'

require "auction_sniper/version"
require 'auction_sniper/main'

module AuctionSniper
  STATUS_JOINING = 'Joining'
  STATUS_LOST = 'Lost'
end
