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

  def test_subscribed_mailboxes_list
    @adapter.expect :list_subscribed_mailboxes, []
    @account.subscribed_mailboxes
    @adapter.verify
  end
end