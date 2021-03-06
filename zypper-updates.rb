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
    out = { "update_amount" => 0 }
    puts out.to_json
    exit 0
end

updates = update_status["update_list"]["update"].size
if updates > 0
    id = Time.now.to_i

    update_status["update_list"]["update"].each do |update|
        update["update_amount"] = updates
        update["update_list_id"] = id
        puts update.to_json
    end
end
