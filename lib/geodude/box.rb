module Geodude
  class Box < BinData::Record
    double_le  :xmin
    double_le  :ymin
    double_le  :xmax
    double_le  :ymax
  end
end
