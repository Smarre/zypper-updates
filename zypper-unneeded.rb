#!/usr/bin/env ruby

require 'json'

#input = ARGF.read

input = `env LANG="C" zypper pa --unneeded`

splitted = input.split "\n"
in_table = false
table_rows = []
splitted.each do |row|
    if row == "S | Repository                               | Name             | Version       | Arch  "
        in_table = true
    end

    if in_table
        table_rows << row
    end
end

table_rows.shift 2

table_rows.each do |row|
    columns = row.split("|").map do |column|
        column.strip!
    end

    out = {
        repository: columns[1],
        name: columns[2],
        version: columns[3],
        arch: columns[4]
    }

    puts out.to_json
end
