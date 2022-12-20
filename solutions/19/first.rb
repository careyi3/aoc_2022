# frozen_string_literal: true

module Day19
  module Part1
    def self.run(path, _)
      blueprints = {}
      FileReader.for_each_line(path) do |line|
        data = line.split.map(&:to_i).reject(&:zero?)
        ore = { ore: data[1] }
        clay = { ore: data[2] }
        obs = { ore: data[3], clay: data[4] }
        geode = { ore: data[5], obs: data[6] }
        blueprints[data[0]] = { geode:, obs:, clay:, ore: }
      end
      blueprint_geodes = {}
      threads = []
      blueprints.each do |id, blueprint|
        # Do work
        resources = { ore: 0, clay: 0, obs: 0, geode: 0 }
        robots = { ore: 1, clay: 0, obs: 0, geode: 0 }
        best = {}
        build(id, blueprint, {}, resources, robots, 0, best)
        blueprint_geodes[id] = best[24]
        puts "#{id}: #{blueprint_geodes[id]}"
      end
      threads.each(&:join)
      puts blueprint_geodes.sort.map { |x| x[0] * x[1] }.sum
    end

    def self.build(id, blueprint, geodes, resources, robots, time, best)
      key = "#{resources.values.join(':')}:#{robots.values.join(':')}:#{time}"
      rank = resources[:geode]
      return unless geodes[key].nil?

      if best[time].nil?
        best[time] = rank
        puts "#{id}: #{key} - #{best[time]}"
      end

      if best[time] < rank
        best[time] = rank
        puts "#{id}: #{key} - #{best[time]}"
      end

      return if rank < best[time] - 2

      if time == 24
        geodes[key] = resources[:geode]
        return
      end

      geodes[key] = resources[:geode]

      # Can afford
      can_afford = {}
      blueprint.each do |type, cost|
        have_resources = []
        cost.each do |cost_type, amount|
          have_resources << resources[cost_type] if resources[cost_type] >= amount
        end
        next unless have_resources.size == cost.size

        can_afford[type] = cost
      end

      # Collect resources
      robots.each do |type, count|
        resources[type] += count
      end

      # Will build
      can_afford.each do |type, cost|
        bought_robots = robots.clone
        bought_resource = resources.clone
        bought_robots[type] += 1
        cost.each do |cost_type, amount|
          bought_resource[cost_type] -= amount
        end
        build(id, blueprint, geodes, bought_resource, bought_robots, time + 1, best)
      end

      build(id, blueprint, geodes, resources.clone, robots.clone, time + 1, best)
    end
  end
end
