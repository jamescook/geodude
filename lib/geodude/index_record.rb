module Geodude
  class IndexRecord < BinData::Record
    endian :big

    uint32 :record_header_offset
    uint32 :content_length

    def size_in_bytes
      ( content_length * 16 ) / 8
    end
  end
end
