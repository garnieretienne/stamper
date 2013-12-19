require 'minitest_helper'

class TestIMAPConnectionManager < Minitest::Test

  def setup
    @imap_options = {
      host: 'localhost',
      user: 'vagrant',
      password: 'vagrant',
      ssl: {verify_mode: 0}
    }
    @imap_connection_manager = Stamper::IMAPConnectionManager.new @imap_options
  end

  def test_open_a_connection_multiple_time
    imap = @imap_connection_manager.open
    assert_instance_of Net::IMAP, imap
    imap_2 = @imap_connection_manager.open
    assert_equal imap, imap_2
    @imap_connection_manager_2 = Stamper::IMAPConnectionManager.new @imap_options
    imap_3 = @imap_connection_manager_2.open
    assert_equal imap, imap_3
  end
end