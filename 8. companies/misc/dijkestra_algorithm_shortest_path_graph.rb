require 'pry'

class Graph
	# Constructor
	def initialize
		@graph = {}	 # the graph // {node => { edge1 => weight, edge2 => weight}, node2 => ...
		@nodes = Array.new
		@INFINITY = 1 << 64
        # binding.pry

	end

	def add_edge(s,t,w) 		# s= source, t= target, w= weight
		if (not @graph.has_key?(s))
			@graph[s] = {t=>w}
		else
			@graph[s][t] = w
		end
        # binding.pry
		# Begin code for non directed graph (inserts the other edge too)

		if (not @graph.has_key?(t))
			@graph[t] = {s=>w}
		else
			@graph[t][s] = w
		end
        # binding.pry

		# End code for non directed graph (ie. deleteme if you want it directed)
		if (not @nodes.include?(s))
			@nodes << s
		end
        # binding.pry

		if (not @nodes.include?(t))
			@nodes << t
		end
        # binding.pry
	end

	# based of wikipedia's pseudocode: http://en.wikipedia.org/wiki/Dijkstra's_algorithm

	def dijkstra(s)
		@d = {}
		@prev = {}
		@nodes.each do |i|
			@d[i] = @INFINITY
			@prev[i] = -1
		end
		@d[s] = 0
		q = @nodes.compact
		while (q.size > 0)
			u = nil;
			q.each do |min|
				if (not u) or (@d[min] and @d[min] < @d[u])
					u = min
				end
			end
			if (@d[u] == @INFINITY)
				break
			end
			q = q - [u]
			@graph[u].keys.each do |v|
				alt = @d[u] + @graph[u][v]
				if (alt < @d[v])
					@d[v] = alt
					@prev[v]  = u
				end
			end
		end
	end

	# To print the full shortest route to a node

	def print_path(dest)
		if @prev[dest] != -1
			print_path @prev[dest]
		end
		print ">#{dest}"
	end

	# Gets all shortests paths using dijkstra

	def shortest_paths(s)
		@source = s
		dijkstra s
		puts "Source: #{@source}"
		@nodes.each do |dest|
			puts "\nTarget: #{dest}"
			print_path dest
			if @d[dest] != @INFINITY
				puts "\nDistance: #{@d[dest]}"
			else
				puts "\nNO PATH"
			end
		end
	end
end
if __FILE__ == $0
	gr = Graph.new
	gr.add_edge("a","b",5)
	gr.add_edge("b","c",3)
	gr.add_edge("c","d",1)
	gr.add_edge("a","d",10)
	gr.add_edge("b","d",2)
	gr.add_edge("f","g",1)
	gr.shortest_paths("a")
end
