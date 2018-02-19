class FakeAuctionServer
  AUCTION_ITEM_JID = 'auction-%s@localhost/Auction'
  AUCTION_PASSWORD = 'auction'

  attr_reader :item_id, :connection, :message_listener, :current_chat

  def initialize(item_id)
    @item_id = item_id
    @connection = Jabber::Client.new(AUCTION_ITEM_JID % item_id)
    @message_listener = SingleMessageListener.new
  end

  def start_selling_item
    connection.connect
    connection.auth AUCTION_PASSWORD
    connection.add_message_callback do |message|
      @current_chat = message.from
      message_listener.process message
    end
  end

  def has_received_join_request_from_sniper
    message_listener.receives_a_message
  end

  def announce_closed
    connection.send(Jabber::Message.new(current_chat))
  end

  def stop
    connection.close
  end

  private

  class SingleMessageListener
    include RSpec::Matchers

    attr_accessor :messages
    def initialize
      @messages = SizedQueue.new 1
    end

    def process(message)
      messages << message
    end

    def receives_a_message
      expect(message(timeout: 5)).not_to be_nil
    end

    private

    def message(timeout:)
      message = nil
      Thread.new { message = messages.pop }.join timeout
      message
    end
  end
end
