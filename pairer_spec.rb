require 'rspec'
require './pairer.rb'
require 'debugger'

describe Pod do
  let(:students) { ['a', 'b', 'c', 'd']}
  let(:pair_log) { { ['a', 'b'] => 50 } }

  before(:each) { @pod = Pod.init_with_options(students, pair_log) }

  it "pairs students who have not paired together" do
    debugger
    pairs = @pod.pair_students

    pairs.should_not include(['a', 'b'])
    pairs.should_not include(['b', 'a'])
    pairs2 = Pod.init_with_options(students, @pod.pair_log).pair_students
    pairs2.should_not include(['a', 'b'])
    pairs2.should_not include(['b', 'a'])

    pairs3 = Pod.init_with_options(students, @pod.pair_log).pair_students
    pairs3.should_not include(['a', 'b'])
    pairs3.should_not include(['b', 'a'])
    p pairs
    p pairs2
    p pairs3
  end
#     pair_log_filename ||= "pair_log"

# names_to_handles = YAML.load_file("names_and_handles")

# students = File.readlines(students_filename).map(&:chomp)
# pod = Pod.init_with_options(students, pair_log)

# File.open("pairs_for_#{ students_filename }_#{Time.new.to_i}", "w") do |f|
#   day_pairs = pod.pair_students
#   Hash[*day_pairs.flatten(1)].keys
#       .map { |pr| [names_to_handles[pr[0]], names_to_handles[pr[1]]] }
#       .each {|pr| f.puts pr.inspect }
#   #f.puts Hash[Hash[*day_pairs.flatten(1)].keys]
# end

# File.open(pair_log_filename, "w") { |f| f.puts pod.pair_log.to_yaml }


end