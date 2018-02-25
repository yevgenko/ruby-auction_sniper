class FakeAuctionServer
  AUCTION_ITEM_JID = 'auction-%s@localhost/Auction'
  AUCTION_PASSWORD = 'auction'

  attr_reader :item_id, :connection, :message_queue, :current_chat_jid

  def initialize(item_id)
    @item_id = item_id
    @connection = Jabber::Client.new(AUCTION_ITEM_JID % item_id)
    @message_queue = SingleMessageQueue.new
  end

  def start_selling_item
    connection.connect
    connection.auth AUCTION_PASSWORD
    connection.add_message_callback do |message|
      @current_chat_jid = message.from
      message_queue << message
    end
  end

  def has_received_join_request_from_sniper
    message_queue.has_a_message
  end

  def announce_closed
    connection.send(Jabber::Message.new(current_chat_jid))
  end

  def stop
    connection.close
  end

  private

  class SingleMessageQueue < SizedQueue
    include RSpec::Matchers

    def initialize
      super(1)
    end

    def has_a_message
      expect(message(timeout: 5)).not_to be_nil
    end

    private

    def message(timeout:)
      message = nil
      Thread.new { message = pop }.join timeout
      message
    end
  end
end
