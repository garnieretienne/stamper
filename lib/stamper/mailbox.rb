module Stamper

  class Mailbox

    attr_reader :name

    def initialize(name: nil)
      raise "No name provided" if !name
      @name = name
    end
  end
end