#!/usr/bin/env ruby

require 'json'
require 'net/http'
require 'active_support/core_ext/hash'

#input = ARGF.read

input = `zypper -x list-updates`

hash = Hash.from_xml(input)

update_status = hash["stream"]["update_status"]

# If true, we have no updates for reason or another.
if update_status["update_list"]["update"].nil?
    exit 0
end

updates = update_status["update_list"]["update"].size
if updates > 0
    out = { "update_amount" => updates, "updates" => {} }
    update_status["update_list"]["update"].each do |update|
        out["updates"][update["name"]] = update
    end
    
    puts out.to_json
end
