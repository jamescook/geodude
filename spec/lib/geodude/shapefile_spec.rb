require "spec_helper"

describe Geodude::Shapefile do
  subject { described_class.new(File.expand_path("spec/fixtures/test1.shp")) }

  describe "#file_header" do
    let(:file_header) { subject.file_header } 

    it "has a file code" do
      expect(file_header.file_code).to eq 9994
    end
  end
end
