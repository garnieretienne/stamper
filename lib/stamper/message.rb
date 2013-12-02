module Stamper

  class Message
    HEADER_FIELDS = :date, :from

    attr_reader *HEADER_FIELDS, :body, :header

    def initialize(header: {}, body: nil)
      @header = header
      @body = body
      parse_header
      validate_header!
    end

    private

    # Generate getter for each fields in the header
    def parse_header
      header.each do |field, value|
        self.instance_variable_set("@#{field}", value) if HEADER_FIELDS.include? field
      end
    end

    # Verify a `date` and `from` fields are present
    def validate_header!
      [:date, :from].each do |field|
        raise "No '#{field}' header field provided" unless self.send(field)
      end
    end
  end
end