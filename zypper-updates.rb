#!/usr/bin/env ruby

require 'json'
require 'net/http'
require 'active_support/core_ext/hash'

#input = ARGF.read

input = `zypper -x list-updates`

hash = Hash.from_xml(input)

updates = hash["stream"]["update_status"]["update_list"]["update"].size
if updates > 0
    out = { "update_amount" => updates, "updates" => {} }
    hash["stream"]["update_status"]["update_list"]["update"].each do |update|
        out["updates"][update["name"]] = update
    end
    
    puts out.to_json
end
