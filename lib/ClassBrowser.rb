require_relative 'HierarchyWriter'


class ClassNode
	attr_reader :klass

	def initialize klass
		@klass = klass;
	end

	def name
		@klass.name
	end

	def ancestors
		class_nodes = []
		@klass.ancestors[1..-1].each do |c|
			if c.class == Class 
				class_node = ClassNode.new c
				class_nodes.insert 0, class_node
			end
		end
		class_nodes
	end

	def descendants
		klass = @klass

		klasses = ObjectSpace.each_object(Class).select do |c| 
			c.superclass == klass 
		end

		klasses.reject! { |c| c.name == nil }

		klasses.sort_by do |c|
			c.name 
		end
	
		class_nodes = []

		klasses.each do |c|
			class_node = ClassNode.new c
			class_nodes << class_node
		end

		class_nodes
	end

	def == other
		@klass == other.klass
	end
end


class ClassBrowser
	attr_reader :root_class_node

	def initialize root_class
		@root_class_node = ClassNode.new root_class
	end

	def dump_descendants
		HierarchyWriter::dump_descendants_of root_class_node
	end
end

#modules = cls.ancestors.select { |a| a.class == Module }.to_s
	
def main
	browser = ClassBrowser.new BasicObject
	browser.dump_descendants
end
