class HierarchyWriter

	# print the descendants of node as a tree using line drawing characters
	# node is expected to respond to #name and #descendants
	def self.dump_descendants_of node, indent = []
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

		puts "○ " + node.name

		desc = node.descendants
		if desc
			desc.each_with_index do |c, index|
				last = index == desc.size - 1
				self.dump_descendants_of c, indent.clone.push(last)
			end
		end
	end

end