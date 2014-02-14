module Geodude
  class PolylineRecord < BinData::Record
    endian :little

    uint32      :shape_type
    box         :box
    uint32      :num_parts
    uint32      :num_points
    array       :parts,  :type => :uint32le, :initial_length => :num_parts
    point_array :points, :initial_length => :num_points
  end
end
