module Geodude
  class MultiPointZRecord < BinData::Record
    int32le     :shape_type
    box         :box
    uint32le    :num_points
    point_array :points,  :initial_length => :num_points
    float_le    :z_min
    float_le    :z_max
    array       :z_array, :type => :float_le, :initial_length => :num_points
    float_le    :m_min
    float_le    :m_max
    array       :m_array, :type => :float_le, :initial_length => :num_points
  end
end
