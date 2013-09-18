require 'rgl/adjacency'

class WeightedUnDirectedGraph < RGL::AdjacencyGraph
  def initialize(edgelist_class = Set, *other_graphs)
    super
    @weights = {}
  end

  def self.[] (*a)
    result = new
    0.step(a.size-2, 3) { |i| result.add_edge(a[i], a[i+1], a[i+2]) }
    result
  end

  def to_s
    (edges.sort_by { |e| e.to_s } +
     isolates.sort_by {|n| n.to_s}).map { |e| e.to_s }.join("\n")
  end

  def isolates
    edges.inject(Set.new(vertices)) { |iso, e| iso -= [e.source, e.target] }
  end

  def add_edge(u, v, w)
    super(u,v)
    @weights[[u,v]] = w
  end

  def weight(u, v)
    @weights[[u,v]]
  end

  def remove_edge(u, v)
    super
    @weights.delete([u,v])
  end

  def remove_vertex(v)
    super
    @weights.delete_if { |k, _| k.include?(v) }
  end

  def edge_class
    WeightedUnDirectedEdge
  end

  def edges
    result = []
    c = edge_class
    each_edge { |u,v| result << c.new(u, v, self) }
    result
  end

  def top_edge
    key = @weights.select {|k, v| v == @weights.values.max }.keys.sample
    [key, @weights[key]]
  end
end

class WeightedUnDirectedEdge < RGL::Edge::UnDirectedEdge
  def initialize(a, b, g)
    super(a,b)
    @graph = g
  end

  def weight
    @graph.weight(source, target)
  end

   def to_s
     "(#{source}-#{weight}-#{target})"
   end
end