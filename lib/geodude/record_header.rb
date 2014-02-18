module Geodude
  class RecordHeader < BinData::Record
    endian :big

    uint32 :record_number
    uint32 :content_length

    def content_length_in_bytes
      ( content_length * 16 ) / 8
    end
  end
end
