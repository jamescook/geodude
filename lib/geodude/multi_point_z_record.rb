module Geodude
  class MultiPointZRecord < BinData::Record
    endian :little

    int32       :shape_type
    box         :box
    int32       :num_points
    point_array :points,  :initial_length => :num_points
    double      :z_min
    double      :z_max
    array       :z_array, :type => :double, :initial_length => :num_points
    double      :m_min
    double      :m_max
    array       :m_array, :type => :double, :initial_length => :num_points
  end
end
