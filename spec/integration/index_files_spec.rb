require "spec_helper"

describe "Geodude" do
  it "can read sample index files" do
    Dir["spec/fixtures/*.shx"].reverse.each do |filename|
      reader = Geodude::Index::Reader.new(filename)
      expect(reader.records.count).to be > 0
    end
  end

  it "can write index files" do
    Dir["spec/fixtures/*.shp"].reverse.each do |filename|
      reader = Geodude::Shapefile::Reader.new(filename)
      writer = Geodude::Index::Writer.from_geodude_reader(reader)

      expect(writer).to eq File.read(filename.sub('.shp', '.shx'))
    end
  end
end
