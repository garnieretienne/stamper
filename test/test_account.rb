require 'minitest_helper'

class TestAccount < Minitest::Test

  def setup
    @email_address = 'testing@provider.tld'
    @account = Stamper::Account.new address: @email_address
  end

  def test_raising_error_if_no_address_provided
    error = assert_raises(RuntimeError){ Stamper::Account.new }
    assert_equal "No address provided", error.message
  end

  def test_address_reader
    assert_equal @email_address, @account.address
  end

  def test_adapter_accessor
    refute @account.adapter?
    @account.adapter = Object.new
    refute_nil @account.adapter
    assert @account.adapter?
  end
end