require "spec_helper"

describe Geodude::Shapefile do
  let(:fixture) { File.expand_path("spec/fixtures/test1.shp") }
  subject { described_class.new(fixture) }

  describe "#file_header" do
    let(:file_header) { subject.file_header } 

    it "has a file code" do
      expect(file_header.file_code).to eq 9994
    end

    it "has a file size" do
      expect(file_header.size_in_bytes).to eq File.size(fixture) # 544
    end
  end
end
