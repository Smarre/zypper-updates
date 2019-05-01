#!/usr/bin/env ruby

require "json"

swap_amounts = []

Dir.glob "/proc/*/status" do |file|
    name = nil
    pid = nil
    File.foreach(file) do |line|
        if line[0..4] == "Name:"
            line.slice!(0..4)
            name = line.strip
            next
        end
        if line[0..3] == "Pid:"
            line.slice!(0..3)
            pid = line.strip
            next
        end
        if line[0..6] == "VmSwap:"
            line.slice!(0..6)
            swap_amount = line.strip

            # No sense to show if there is no swap used...
            break if swap_amount == "0 kB"

            swap_amounts << {
                name: name,
                pid: pid,
                swap_amount: swap_amount
                }
            break
        end
    end
end

sorted = swap_amounts.sort do |a, b|
    a[:swap_amount].tr("^0-9", '').to_i <=> b[:swap_amount].tr("^0-9", '').to_i
end

puts sorted.to_json