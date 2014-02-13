module Geodude
  class PartArray < BinData::Array
    uint32be :idx
  end
end
