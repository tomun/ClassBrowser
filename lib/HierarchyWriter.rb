class HierarchyWriter

	# print the descendants of node as a tree using line drawing characters
	# node is expected to respond to #name and #descendants
	def self.dump_descendants_of node, indent = [], depth = :depth_all
		indent.each_with_index do |draw, index| 
			last = index == indent.size - 1 
			if draw 
				print last ? "└" : " "
			else
				print last ? "├" : "│"
			end
			print last ? "─" : " "
		end 

		puts "○ " + node.name

		if depth != :depth_none
			desc = node.descendants
			if desc
				if depth == :depth_immediate
					depth = :depth_none
				end
				desc.each_with_index do |c, index|
					last = index == desc.size - 1
					self.dump_descendants_of c, indent.clone.push(last), depth
				end
			end
		end
	end

	# print the ancestors of node as a tree using line drawing characters
	# node is expected to respond to #name and #ancestors
	# returns the indent array which can be passed to dump_descendants_of
	def self.dump_ancestors_of node

		indent = []
		ansc = node.ancestors

		ansc.each_with_index do |c, index| 
			indent.each_with_index do |draw, index| 
				if index > 0 
					print "  "
				end
			end 

			if index != 0
				print "└─"
			end
			puts "○ " + c.name
			last = index == indent.size - 1 
			indent.push !last
		end 

		indent
	end

	# prints the ancestors and descendants of node
	def self.dump_hierarchy_of node, depth = :depth_all
		indent = HierarchyWriter::dump_ancestors_of node
		HierarchyWriter::dump_descendants_of node, indent, depth
	end

end