module Geodude
  class RecordHeader < BinData::Record
    uint32be :record_number
    uint32be :content_length

    def content_length_in_bytes
      ( content_length * 16 ) / 8
    end
  end
end
