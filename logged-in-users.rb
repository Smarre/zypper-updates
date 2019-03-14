#!/usr/bin/env ruby

require "json"

# Headers:
# USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
=begin
smar pts/1 2a01:4f9:2a:64d:2000::30 08:29   24:34   0.06s  0.01s screen -rd
smar pts/3 :pts/1:S.0 13:03   28:32  46:00  46:00  irssi
nortti pts/0 :pts/5:S.0  su15   10:15  27:29  27:28  irssi
nortti pts/2 :pts/5:S.1  su15   17days  3.55s  0.00s offtopia.log
nortti pts/5 mosh-        13:18   10:15   0.92s  0.89s screen -x
smar pts/4 2a01:4f9:2a:64d:2000::21 09:35   28:32   0.03s  0.03s -fish
vimana pts/8 212.66.216.32 31tammi19  2days  0.50s  0.50s -fish
root pts/9 2a01:4f9:2a:64d:2000::30 13:05    0.00s  2.77s  0.00s w -n
=end

logged_in_users = `w -n`
logged_in_users = logged_in_users.split "\n"

logged_in_users.each do |logged_in_user|
    fields = logged_in_user.split " "
    username = fields[0]
    tty = fields[1]
    from = fields[2]
    login_at = fields[3]
    idle = fields[4]
    jcpu = fields[5]
    pcpu = fields[6]
    executed_command = fields[7]

    out = {
        "username" => username,
        "tty" => tty,
        "from" => from,
        "login_at" => login_at,
        "idle" => idle,
        "jcpu" => jcpu,
        "pcpu" => pcpu,
        "executed_command" => executed_command,
    }

    puts out.to_json
end