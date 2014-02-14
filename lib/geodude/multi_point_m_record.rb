module Geodude
  class MultiPointMRecord < BinData::Record
    endian :little

    uint32       :shape_type
    box          :box
    uint32       :num_points
    point_array  :points,  :initial_length => :num_points
    double       :m_min
    double       :m_max
    array        :m_array, :type => :double_le, :initial_length => :num_points
  end
end
