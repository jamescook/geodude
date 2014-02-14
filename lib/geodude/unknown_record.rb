module Geodude
  class UnknownRecord < BinData::Record
    int32le :shape_type
    string :data
  end
end
