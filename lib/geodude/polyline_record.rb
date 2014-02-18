module Geodude
  class PolylineRecord
    def initialize(attributes={})
      @encoded = attributes.delete(:encoded)
      @attributes = attributes
    end

    def [](key)
      if @encoded
        @attributes.fetch(key) do |key|
          decode(key)
        end
      else
        @attributes.fetch(key)
      end
    end

    def []=(key,value)
      @attributes[key] = value
    end

    private

    def decode(key)
      case key
      when :shape_type then
        @attributes[:shape_type] = shape_type_data
      when :box then
        @attributes[:box] = box_data
      when :num_parts then
        @attributes[:num_parts] = num_parts
      when :num_points then
        @attributes[:num_points] = num_points
      when :parts then
        @attributes[:parts] = parts
      when :points then
        @attributes[:points] = points
      else
        raise KeyError, "#{key} is not a valid attribute"
      end
    end

    def shape_type_data
      @encoded[0,4].unpack("V").first
    end

    def box_data
      @encoded[4,32].unpack("EEEE")
    end

    def num_parts
      @num_parts ||= @encoded[36,4].unpack("V").first
    end

    def num_points
      @num_points ||= @encoded[40,4].unpack("V").first
    end

    def parts
      offset = 44
      @encoded[offset, (num_parts) + 4].unpack("V*")
    end

    def points
      offset = 43 + 4 + num_parts
      @encoded[offset, (num_points * 8)].unpack("E*")
    end
  end
end
