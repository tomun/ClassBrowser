require_relative "ClassNode"
require_relative 'HierarchyWriter'

class ClassBrowser
	attr_reader :class_root_node
	attr_reader :show_help
	attr_reader :depth
	attr_reader :show_modules
	attr_reader :show_methods

	def initialize root_class = Object
		@class_root_node = ClassNode.new root_class
		@show_help = false
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

	def show_help
		if @show_help
			puts "Usage: ClassBrowser [class] [switches]
Where:
class is a Class or Module name
args may be:
  -h:   show this message
  -da:  show the all descendants of this class
  -di:  show the immediate descendants of this class
  -dn:  do not show the descendants of this class
  -m:   show the Modules included by this Class or Module
  -ma:  show all methods of this Class or Module
  -mi:  show the instance methods of this Class
  -mc:  show the class methods of this Class
  -mn:  do not show any methods of this Class or Module
ClassBrowser with no arguments enters interactive mode
"
			true
		else
			false
		end
	end

	def dump
		if !show_help
			dump_hierarchy
			dump_modules
			dump_methods
		end
	end


	def parse_arguments argv
		flags = {
			"-h"  => lambda { @show_help = true },
			"-di" => lambda { @depth = :depth_immediate },
			"-da" => lambda { @depth = :depth_all },
			"-dn" => lambda { @depth = :depth_none },
			"-m"  => lambda { @show_modules = true },
			"-mn" => lambda { @show_methods = :methods_none },
			"-ma" => lambda { @show_methods = :methods_all },
			"-mi" => lambda { @show_methods = :methods_instance },
			"-mc" => lambda { @show_methods = :methods_class },
		}

		argv.each do |arg|
			l = flags[arg]
			if l
				l.call
			end
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
