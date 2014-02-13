module Geodude
  class FileHeader < BinData::Record
    int32be    :file_code
    string     :unused, :read_length => 5 * 4 # bytes
    uint32be   :file_length
    uint32le   :version
    uint32le   :shape_type
    double_le  :xmin
    double_le  :ymin
    double_le  :xmax
    double_le  :ymax
    double_le  :zmin
    double_le  :zmax
    double_le  :mmin
    double_le  :mmax
  end
end
