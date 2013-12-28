require 'minitest_helper'

class TestMailbox < Minitest::Test

  def setup
    @account = Class.new do
      def self.address
        "testing@domain.tld"
      end

      def self.adapter
        @adapter || (@adapter = MiniTest::Mock.new)
      end
    end
    @name = "INBOX"
    @mailbox = Stamper::Mailbox.new name: @name, account: @account
  end

  def test_raising_error_if_no_name_provided
    error = assert_raises(RuntimeError){ Stamper::Mailbox.new }
    assert_equal "No name provided", error.message
  end

  def test_raising_error_if_no_account_is_provided
    error = assert_raises(RuntimeError){ Stamper::Mailbox.new name: @name}
    assert_equal "No account provided", error.message
  end

  def test_name_reader
    assert_equal @name, @mailbox.name
  end

  def test_getting_messages_from_account_adapter
    @account.adapter.expect :list_messages_in_mailbox, 
      [Stamper::Adapter::IMAPAdapter::Message.new(1, rfc822_sample)], 
      [mailbox: @mailbox.name]
    @mailbox.messages
    @account.adapter.verify
    messages = @mailbox.messages
    assert_instance_of Stamper::Message, messages.first
    assert_equal @mailbox, messages.first.mailbox
  end
end