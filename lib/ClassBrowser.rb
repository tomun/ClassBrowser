require_relative "ClassNode"
require_relative 'HierarchyWriter'

class ClassBrowser
	attr_reader :class_root_node
	attr_reader :depth
	attr_reader :show_modules
	attr_reader :show_methods

	def initialize root_class = Object
		@class_root_node = ClassNode.new root_class
		@depth = :depth_immediate
		@show_modules = false
		@show_methods = :methods_none
	end

	def dump_hierarchy
		HierarchyWriter::dump_hierarchy_of @class_root_node, @depth
	end

	def pretty_print prefix, methods, suffix = ""
		methods.sort_by { |m| m.to_s }
		width = ENV['COLUMNS'].to_i
		col = 0
		methods.each do |m|
			msg = '%-24.24s' % "#{prefix}#{m.to_s}#{suffix}"
			col += msg.length
			if col >= width
				print "\n"
				col = msg.length
			end
			print msg
		end
		print "\n"
	end

	def dump_modules
		if @class_root_node.klass && @show_modules

			modules = @class_root_node.klass.ancestors.select { |a| a.class == Module }
			pretty_print "[", modules, "]"
		end
	end

	def dump_methods
		if @class_root_node.klass && @show_methods != :methods_none
			if @show_methods == :methods_all || @show_methods == :methods_class
				methods = @class_root_node.klass.singleton_methods
				pretty_print "::", methods
			end
			if @show_methods == :methods_all || @show_methods == :methods_instance
				methods = @class_root_node.klass.instance_methods(false)
				pretty_print "#", methods
			end
		end
	end

	def dump
		dump_hierarchy
		dump_modules
		dump_methods
	end


	def parse_arguments argv
		if argv.include? "-di"
			@depth = :depth_immediate
		elsif argv.include? "-da"
			@depth = :depth_all
		elsif argv.include? "-dn"
			@depth = :depth_none
		end

		if argv.include? "-m"
			@show_modules = true
		end

		if argv.include? "-mn"
			@show_methods = :methods_none
		elsif argv.include? "-ma"
			@show_methods = :methods_all
		elsif argv.include? "-mi"
			@show_methods = :methods_instance
		elsif argv.include? "-mc"
			@show_methods = :methods_class
		end

		class_name_index = argv.index{ |o| !o.start_with?("-") }
		if class_name_index
			class_name = argv[class_name_index]
			klass = nil
			begin
				klass = Object.const_get(class_name)
			rescue
				puts "Unknown class"
				klass = nil
			end
			@class_root_node = ClassNode.new klass
		end
	end

	def interactive

		failsafe = 1

		loop do
			print "\n#{@class_root_node.name}> "
			args = gets.split(/\s+/)

			if args == nil || args.length == 0
				break
			end

			parse_arguments args
			dump

			failsafe += 1
			break if failsafe > 100
		end 
	end
end
	
def main
	browser = ClassBrowser.new
	if ARGV.length > 0
		browser.parse_arguments ARGV
		browser.dump
	else
		browser.interactive
		puts "Bye!"
	end
end

main
