require 'spec_helper'
require 'capybara/rspec'
require './spec/fake_auction_server'
require './spec/application_runner'

Capybara.register_server :thin do |app, port|
  require 'rack/handler/thin'
  Rack::Handler::Thin.run(app, :Port => port)
end

Capybara.server = :thin, { Silent: true  }

RSpec.describe 'Auction Snipper', type: :end_to_end do
  let(:auction) { FakeAuctionServer.new "item-54321" }
  let(:application) { ApplicationRunner.new }

  after do
    auction.stop
  end

  it 'joins auction until auction closes' do
    auction.start_selling_item
    application.start_bidding_in auction
    auction.has_received_join_request_from_sniper
    auction.announce_closed
    application.shows_sniper_has_lost_auction
  end
end
