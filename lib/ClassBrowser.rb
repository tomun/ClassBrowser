def descendants_of cls
	classes = ObjectSpace.each_object(Class).select do |c| 
		c.superclass == cls 
	end

	classes.reject! { |c| c.name == nil }

	#STDERR.puts "**** classes = #{classes.inspect}"

	classes.sort_by do |c|
		c.name 
	end
end

def dump_descendants_of cls, indent = []
	indent.each_with_index do |draw, index| 
		last = index == indent.size - 1 
		if draw 
			print last ? "└" : " "
		else
			print last ? "├" : "│"
		end
		if last
			print "─"
		else
			print " "
		end
	end 

	modules = cls.ancestors.select { |a| a.class == Module }.to_s
	puts "○ " + cls.name + " - " + modules

	desc = descendants_of cls
	desc.each_with_index do |c, index|
		last = index == desc.size - 1
		dump_descendants_of c, indent.clone.push(last)
	end
end

def main
	dump_descendants_of BasicObject
end
