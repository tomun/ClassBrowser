require_relative '../lib/ClassBrowser'

describe "Test that the ObjectSpace hierarchy can be displayed" do

    it "main runs" do
      expect { main }.to output(/BasicObject/).to_stdout
    end
end
