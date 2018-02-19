class ApplicationRunner
  SNIPER_JID = 'sniper@localhost/Auction'
  SNIPER_PASSWORD = 'sniper'

  attr_reader :session

  def start_bidding_in(auction)
    app = AuctionSniper::Main.new(
      sniper_jid: SNIPER_JID,
      sniper_password: SNIPER_PASSWORD,
      item_id: auction.item_id
    )
    @session = AuctionSniperSession.new(:selenium_chrome, app)
    session.visit '/'
    session.shows_sniper_status AuctionSniper::STATUS_JOINING
  end

  def shows_sniper_has_lost_auction
    session.shows_sniper_status AuctionSniper::STATUS_LOST
  end

  private

  class AuctionSniperSession < Capybara::Session
    def shows_sniper_status(status)
      assert_text status
    end
  end
end
