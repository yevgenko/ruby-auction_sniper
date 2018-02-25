module AuctionSniper
  class Main
    AUCTION_ITEM_JID = 'auction-%s@localhost/Auction'

    attr_reader :connection, :current_status, :event_source

    def initialize(sniper_jid:, sniper_password:, item_id:)
      @current_status = STATUS_JOINING
      @connection = Jabber::Client.new(sniper_jid)
      connection.connect
      connection.auth sniper_password
      connection.send(
        Jabber::Message.new AUCTION_ITEM_JID % item_id
      )
      connection.add_message_callback do |message|
        @current_status = STATUS_LOST
        event_source.send current_status
      end
    end

    def call(env)
      if Faye::EventSource.eventsource?(env)
        @event_source = Faye::EventSource.new(env)

        event_source.send current_status

        event_source.on :close do |event|
          @event_source = nil
        end

        # Return async Rack response
        event_source.rack_response
      else
        user_interface_response
      end
    end

    private

    def user_interface_response
      [200, {"Content-Type" => "text/html"}, File.open('./resources/index.html', File::RDONLY)]
    end
  end
end
