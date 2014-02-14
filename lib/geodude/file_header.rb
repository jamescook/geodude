module Geodude
  class FileHeader < BinData::Record
    uint32be    :file_code
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

    # File length is expressed in 16 bit words
    def size_in_bytes
      ( file_length * 16 ) / 8
    end
  end
end
