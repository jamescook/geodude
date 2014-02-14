require "spec_helper"

describe "Geodude" do
  it "generates valid shapefiles from its own reader" do
    Dir["spec/fixtures/*.shp"].reverse.each do |filename|
      reader = Geodude::Shapefile::Reader.new(filename)
      writer = Geodude::Shapefile::Writer.from_geodude_reader(reader)
      expect(writer).to eq File.read(filename)
    end
  end
end
