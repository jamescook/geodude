module Geodude
  class PolylineRecord < BinData::Record
    int32le     :shape_type
    box         :box
    uint32le    :num_parts
    uint32le    :num_points
    part_array  :parts,  :initial_length => :num_parts #:read_until => lambda { array.size ==  num_parts }
    point_array :points, :initial_length => :num_points

    #Byte 0  Shape         Type       3      Integer 1 Little
    #Byte 4  Box           Box        Double 4  Little
    #Byte 36 NumParts      NumParts   Integer 1 Little
    #Byte 40 NumPoints     NumPoints  Integer 1 Little
    #Byte 44 Parts Parts   Integer    NumParts  Little
    #Byte X  Points Points Point      NumPoints Little

    #Note: X = 44 + 4 * NumParts
  end
end
