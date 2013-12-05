require 'minitest_helper'

class TestAccount < Minitest::Test

  def setup
    @email_address = 'testing@provider.tld'
    @adapter = MiniTest::Mock.new
    @account = Stamper::Account.new address: @email_address, adapter: @adapter
  end

  def test_raising_error_if_no_address_provided
    error = assert_raises(RuntimeError){ Stamper::Account.new(adapter: MiniTest::Mock.new) }
    assert_equal "No address provided", error.message
  end

  def test_raising_error_if_no_adapter_provided
    error = assert_raises(RuntimeError){ Stamper::Account.new(address: @email_address) }
    assert_equal "No adapter provided", error.message
  end

  def test_address_reader
    assert_equal @email_address, @account.address
  end

  def test_adapter_reader
    @adapter.expect :nil?, false
    refute_nil @account.adapter
  end

  def test_list_subscribed_mailboxes
    @adapter.expect :list_subscribed_mailboxes, [{name: 'INBOX'}, {name: 'Spam'}]
    mailboxes = @account.list_subscribed_mailboxes
    @adapter.verify
    assert_instance_of Stamper::Mailbox, mailboxes.first
  end

  def test_list_messages_in_mailbox
    @adapter.expect :list_messages_in_mailbox, [
      {
        header: {
          date: "Mon, 7 Feb 1994 21:52:25 -0800 (PST)",
          from: "Contact name <contact_address@provider.tld>"
        }
      }
    ]
    messages = @account.list_messages_in_mailbox(mailbox: 'Mailbox1')
    @adapter.verify
    assert_instance_of Stamper::Message, messages.last
  end
end