module Stamper

  class Account

    attr_reader :address
    attr_accessor :adapter

    def initialize(address: nil)
      raise "No address provided" if !address
      @address = address
    end

    def adapter?
      !@adapter.nil?
    end
  end
end