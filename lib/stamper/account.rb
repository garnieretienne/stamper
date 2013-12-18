module Stamper

  class Account

    attr_reader :address, :adapter

    def initialize(address: nil, adapter: nil)
      raise "No address provided" unless address
      raise "No adapter provided" unless adapter
      @address = address
      @adapter = adapter
    end

    def method_missing(name, *args, &block)
      adapter.send(name, *args, &block)
    end
  end
end