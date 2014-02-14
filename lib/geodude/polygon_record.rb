module Geodude
  class PolygonRecord < BinData::Record
    int32le     :shape_type
  end
end
