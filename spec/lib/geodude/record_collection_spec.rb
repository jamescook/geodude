require "spec_helper"

describe Geodude::RecordCollection do
  let(:fixture) { File.expand_path("spec/fixtures/test.shp") }
  let(:file) { File.open(fixture) }

  after { file.rewind }

  describe "#count" do
    subject { described_class.new(file) }

    it "knows the total number of records" do
      expect(subject.count).to eq 3
    end
  end

  describe "#[]" do
    subject { described_class.new(file) }

    it "returns the record at the specified index" do
      expect(subject[0]).to be_an_instance_of(Geodude::PolygonRecord)
    end
  end
end
