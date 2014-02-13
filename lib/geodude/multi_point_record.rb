module Geodude
  class MultiPointRecord < BinData::Record
    uint32le    :shape_type
    box         :box
    uint32le    :num_points
    point_array :points, :initial_length => :num_points
  end
end
