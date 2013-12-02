require 'minitest_helper'

class TestStamper < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Stamper::VERSION
  end
end
