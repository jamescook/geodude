module Geodude
  class PartArray < BinData::Array
    uint32le :idx
  end
end
