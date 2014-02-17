require "spec_helper"

describe "Geodude" do
  it "can read sample index files" do
    Dir["spec/fixtures/*.shx"].reverse.each do |filename|
      reader = Geodude::Index::Reader.new(filename)
      expect(reader.records.count).to be > 0
    end
  end
end
