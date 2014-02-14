module Geodude
  class PolylineMRecord < BinData::Record
    endian :little

    uint32       :shape_type
    box          :box
    uint32       :num_parts
    uint32       :num_points
    part_array   :parts,   :initial_length => :num_parts
    point_array  :points,  :initial_length => :num_points

    count_bytes_remaining :bytes_remaining

    double       :m_min, :onlyif => :has_m_data?
    double       :m_max, :onlyif => :has_m_data?
    array        :m_array, :type => :double_le, :initial_length => :num_points, :onlyif => :has_m_data?


    def has_m_data?
      bytes_remaining.nonzero?
    end
  end
end
