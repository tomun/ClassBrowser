require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require_relative '../lib/HierarchyWriter'
require_relative '../lib/ClassBrowser'

# sample classes used in tests below
class Foo < Object;	end
class Bar < Foo; end

class Parent < Object; end
class Brother < Parent; end
class Sister < Parent; end
class Grandchild < Sister; end

describe HierarchyWriter do

	before do
		class Foo
			attr_reader :name
			attr_reader :descendants

			def initialize name, descendants
				@name = name
				@descendants = descendants
			end
		end

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

	context "::dump_hierarchy_of" do

		it "can write out the hierarchy of 'node' objects" do
			node = ClassNode.new Parent

			expect { HierarchyWriter::dump_hierarchy_of(node) }.to output(
"○ BasicObject
└─○ Object
  └─○ Parent
    ├─○ Sister
    │ └─○ Grandchild
    └─○ Brother
"
				).to_stdout
		end
	end

	it "main runs with argument 'Parent'" do
    	ARGV.clear
    	ARGV << "Parent"
    	expect { main }.to output(
"○ BasicObject
└─○ Object
  └─○ Parent
    ├─○ Sister
    │ └─○ Grandchild
    └─○ Brother
"
    		).to_stdout

    end
end

describe ClassNode do

	before do
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

describe ClassBrowser do

	before do
		@browser = ClassBrowser.new 
	end

	it "can parse the '-di' argument" do
		@browser.parse_arguments ["-di"]
		expect(@browser.depth).to eq(:immediate_descendants)
	end

	it "can parse the '-da' argument" do
		@browser.parse_arguments ["-da"]
		expect(@browser.depth).to eq(:all_descendants)
	end

	it "can parse a class name argument" do
		@browser.parse_arguments ["-foo", "Array", "-bar"]
		expect(@browser.class_root_node.klass.name).to eq("Array")
	end

	it "a bogus class name argument defaults to Object" do
		@browser.parse_arguments ["-foo", "Jabberwocky", "-bar"]
		expect(@browser.class_root_node.klass.name).to eq("Object")
	end

end

describe "Test that the ObjectSpace hierarchy can be displayed" do

    it "main runs with no arguments" do
    	ARGV.clear
      	expect { main }.to output(/BasicObject/).to_stdout
    end

end
