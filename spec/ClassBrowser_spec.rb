require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require_relative '../lib/HierarchyWriter'
require_relative '../lib/ClassBrowser'

describe HierarchyWriter do

	class Foo
		attr_reader :name
		attr_reader :descendants

		def initialize name, descendants
			@name = name
			@descendants = descendants
		end
	end

	before do
		@tree = Foo.new("Plant", [
			Foo.new("Tree",	[
				Foo.new("Pine", nil), 
				Foo.new("Fir", nil)
			]),
			Foo.new("Flower", [
				Foo.new("Rose", nil), 
				Foo.new("Carnation", nil)
			])
		]);
	end

	context "::dump_descendants_of" do

		it "can write out a simple Hierarchy of 'node' objects that respond to #name and #descendants" do

		expect { HierarchyWriter::dump_descendants_of(@tree) }.to output(
"○ Plant
├─○ Tree
│ ├─○ Pine
│ └─○ Fir
└─○ Flower
  ├─○ Rose
  └─○ Carnation
"
			).to_stdout
		end
	end

	context "::dump_ancestors_of" do

		it "can write out the ancestors of 'node' objects that respond to #ancestors" do
			expect { HierarchyWriter::dump_ancestors_of(ClassNode.new(Exception)) }.to output(
"○ BasicObject
└─○ Object
"		
			).to_stdout
		end

	end
end

describe ClassNode do

	before do

		class Foo < Object
		end

		class Bar < Foo
		end

		@node = ClassNode.new Foo
	end

	it "can return the name of the class" do
		expect(@node.name).to eq("Foo")
	end

	it "can return the ancestors of the class" do
		expect(@node.ancestors).to contain_exactly(ClassNode.new(BasicObject), ClassNode.new(Object))
	end

	it "can return the descendants of the class" do
		expect(@node.descendants).to eq([ClassNode.new(Bar)])
	end

end

describe "Test that the ObjectSpace hierarchy can be displayed" do

    it "main runs" do
      expect { main }.to output(/BasicObject/).to_stdout

    end
end
