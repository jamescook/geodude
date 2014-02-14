module Geodude
  class PolygonRecord < BinData::Record
    int32le     :shape_type
    box         :box
    uint32le    :num_parts
    uint32le    :num_points
    part_array  :parts,  :initial_length => :num_parts
    point_array :points, :initial_length => :num_points
  end
end
