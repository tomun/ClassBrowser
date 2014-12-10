require_relative "ClassNode"
require_relative 'HierarchyWriter'

class ClassBrowser
	attr_reader :class_root_node
	attr_reader :depth

	def initialize root_class = Object
		@class_root_node = ClassNode.new root_class
		@depth = :depth_immediate
	end

	def dump_hierarchy
		HierarchyWriter::dump_hierarchy_of @class_root_node, @depth
	end

	def parse_arguments argv
		if argv.include? "-di"
			@depth = :depth_immediate
		end
		if argv.include? "-da"
			@depth = :depth_all
		end

		class_name_index = argv.index{ |o| !o.start_with?("-") }
		if class_name_index
			class_name = argv[class_name_index]
			klass = Object
			begin
				klass = Object.const_get(class_name)
			rescue
				klass = Object
			end
			@class_root_node = ClassNode.new klass
		end
	end

	def interactive

		failsafe = 1

		loop do
			args = gets.split(" ")

			if args == nil || args.length == 0
				break
			end

			parse_arguments args
			dump_hierarchy

			failsafe += 1
			break if failsafe > 100
		end 
	end
end

#modules = cls.ancestors.select { |a| a.class == Module }.to_s
	
def main
	browser = ClassBrowser.new
	browser.parse_arguments ARGV
	browser.dump_hierarchy
end
