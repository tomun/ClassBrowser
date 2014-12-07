def descendants_of cls
	ObjectSpace.each_object(Class).select { |c| c.superclass == cls }.sort_by { |c| c.name }
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
