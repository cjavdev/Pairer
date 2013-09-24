#!/usr/bin/env ruby
require 'yaml'
require 'fileutils'
require './weighted_undirected_graph.rb'
require 'debugger'

class Pod < WeightedUnDirectedGraph
  attr_accessor :students, :pair_log

  # need this initializer because the super duper initializer
  # takes specific arguments
  # _students_ is an array of the students github handles
  # _pair_log_ is a hash in format { ["student1", "student2"] => weight }
  def self.init_with_options(students, pair_log = {})
    p = Pod.new
    p.students = students
    p.pair_log = pair_log
    p
  end

  def pop
    e = top_edge
    remove_edge(*e[0])
    remove_vertex(e[0][0])
    remove_vertex(e[0][1])
    e
  end

  def build_graph
    # latest edge weights from `pair_value`
    self.students.combination(2).each do |pair|
      add_edge(*pair.sort, pair_value(pair))
    end
  end

  def pair_students
    pod_copy = self.dup

    pairings = []
    50.times do |t|
      pairings << pod_copy.pair_students!
    end

    pairing_scores = Hash.new(0)
    pairings.each do |pairing|
      pairing.each do |pair|
        pairing_scores[pairing] += pair[1]
      end
    end

    debugger

    # this gets the key (a.k.a pairing) for the highest pairing
    pairs = pairing_scores.sort_by { |_, v| -v }.first[0]

    debugger
    adjusted_weight_edges = pairs.map do |p|
      x = p.clone
      x[1] = x[1]/2 # could be average pair weighting
      x
    end

    update_pair_log adjusted_weight_edges
    pairs
  end

  def pair_students!
    # every time students are paired, rebuild the graph with the
    build_graph

    pairs = []
    until pairs.length == students.length / 2
      # randomly selects a pair from the pairs with the highest edge weight
      # this is still not perfect.
      pairs << self.pop
    end

    adjusted_weight_edges = pairs.map do |p|
      x = p.clone
      x[1] = x[1]/2 # could be average pair weighting
      x
    end

    update_pair_log adjusted_weight_edges
    pairs
  end

  def update_pair_log adjusted_weights
    self.pair_log.merge!(Hash[*adjusted_weights.flatten(1)])
  end

  def pair_value(pair)
    if self.pair_log.keys.include?(pair)
      self.pair_log[pair]
    else
      100
    end
  end
end

if ARGV[0]
  students_filename = ARGV[0]
else
  print "\nPlease enter filename for student list: "
  students_filename = gets.chomp
end

pair_log = {}

if ARGV[1]
  pair_log_filename = ARGV[1]
  pair_log = YAML.load_file(pair_log_filename)
else
  if File.exist?("pair_log")
    FileUtils.cp("pair_log", "pair_log#{Time.new.to_i}")
    pair_log = YAML.load_file("pair_log")
  end
end

pair_log_filename ||= "pair_log"

students = File.readlines(students_filename).map(&:chomp)
pod = Pod.init_with_options(students, pair_log)

File.open("pairs_for_#{ students_filename }_#{Time.new.to_i}", "w") do |f|
  day_pairs = pod.pair_students
  f.puts Hash[Hash[*day_pairs.flatten(1)].keys]
end

File.open(pair_log_filename, "w") { |f| f.puts pod.pair_log.to_yaml }
