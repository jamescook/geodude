module Geodude
  class NullShapeRecord < BinData::Record
    uint32le :shape_type
  end
end
