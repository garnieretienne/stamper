require 'minitest_helper'

class TestMemoryStore < Minitest::Test

  def setup
    @store_access_1 = Stamper::Utils::MemoryStore.instance
    @store_access_2 = Stamper::Utils::MemoryStore.instance
  end

  def test_is_singleton
    assert_equal @store_access_1, @store_access_2
  end

  def test_object_storage_in_memory
    object_1 = Object.new
    stored_object = @store_access_1.set "test_1", object_1
    retrieved_object = @store_access_2.get "test_1"
    assert_equal stored_object, retrieved_object
  end

  def test_object_searching
    refute @store_access_2.find("test_2")
    object_2 = Object.new
    @store_access_1.set "test_2", object_2
    assert @store_access_2.find("test_2")
  end

  def test_object_storeage_deletion
    object_3 = Object.new
    @store_access_1.set "test_3", object_3
    @store_access_1.unset "test_3"
    refute @store_access_2.find("test_3")
  end

  def test_pool_purging
    object_4 = Object.new
    @store_access_1.set "test_4", object_4
    @store_access_2.purge
    assert @store_access_2.pool.empty?
  end
end