require "spec_helper"

describe Geodude::Shapefile::Writer do
  let(:fixture) { File.expand_path("spec/fixtures/test2.shp") }
  let(:reader)  { Geodude::Shapefile::Reader.new(fixture) }

  describe ".from_geodude_reader" do
    it "can generate a valid shapefile" do
      writer = described_class.from_geodude_reader(reader)
      expect(writer).to eq File.read(fixture)
    end
  end
end
