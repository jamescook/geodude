require "bindata"
require_relative "./geodude/file_header"
require_relative "./geodude/record_header"
require_relative "./geodude/index_record"
require_relative "./geodude/point_array"
require_relative "./geodude/part_array"
require_relative "./geodude/box"
require_relative "./geodude/null_shape_record"

require_relative "./geodude/point_record"
require_relative "./geodude/point_m_record"
require_relative "./geodude/point_z_record"

require_relative "./geodude/polyline_record"
require_relative "./geodude/polyline_m_record"
require_relative "./geodude/polyline_z_record"

require_relative "./geodude/polygon_record"
require_relative "./geodude/polygon_m_record"
require_relative "./geodude/polygon_z_record"

require_relative "./geodude/multi_point_record"
require_relative "./geodude/multi_point_m_record"
require_relative "./geodude/multi_point_z_record"

require_relative "./geodude/multi_patch_record"
require_relative "./geodude/unknown_record"
require_relative "./geodude/record_collection"
require_relative "./geodude/index_record_collection"
require_relative "./geodude/shapefile/reader"
require_relative "./geodude/shapefile/writer"

require_relative "./geodude/index/reader"

module Geodude
end
