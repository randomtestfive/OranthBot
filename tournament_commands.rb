require 'yaml'
require_relative 'config_loader'
require_relative 'regexes.rb'
require_relative 'tournament.rb'

ident = CONFIG['bot']['ident']

if File.exists? 'tournaments.yml'
  $tournaments = YAML.load_file('tournaments.yml')
else
  $tournaments = Hash.new
end

def write_tournament_yaml
  File.open('tournaments.yml', 'w') do |file|
    file.puts $tournaments.to_yaml
  end
end

def join_tournament(t, name)
  if $tournaments[t] != nil && !$tournaments[t].started?
    $tournaments[t].add_player(name)
    "Joined tournament \"#{t}\" as \"#{name}\""
  elsif $tournaments[t] != nil && $tournaments[t].started?
    "Tournament already started."
  else
    "No tournamnet \"#{t}\" exists."
  end
end

def leave_tournament(t, name)
  if $tournaments[t] != nil && !$tournaments[t].started?
    $tournaments[t].remove_player(name)
    "Removed \"#{name}\" from tournament \"#{t}\""
  elsif $tournaments[t] != nil && $tournaments[t].started?
    "Tournament already started."
  else
    "No tournamnet \"#{t}\" exists."
  end
end

$tournament_create_command = Proc.new do |event|
  m = $tournament_create_regex.match(event.content)
  $tournaments[m[1]] = Tournament.new
  event.respond "Created tournament \"#{m[1]}\""
  write_tournament_yaml
end

$tournament_join_command = Proc.new do |event|
  m = $tournament_join_regex.match(event.content)
  event.respond join_tournament(m[1], event.user.name)
  write_tournament_yaml
end

$tournament_add_command = Proc.new do |event|
  m = $tournament_add_regex.match(event.content)
  event.respond join_tournament(m[2], m[1])
  write_tournament_yaml
end

$tournament_remove_command = Proc.new do |event|
  m = $tournament_remove_regex.match(event.content)
  event.respond leave_tournament(m[2], m[1])
  write_tournament_yaml
end

$tournament_leave_command = Proc.new do |event|
  m = $tournament_leave_regex.match(event.content)
  event.respond leave_tournament(m[1], event.user.name)
  write_tournament_yaml
end

$tournament_players_command = Proc.new do |event|
  m = $tournament_players_regex.match(event.content)
  if $tournaments[m[1]] != nil
    event.respond %Q|Players:\n#{$tournaments[m[1]].players_start.join("\n")}|
  else
    event.respond "No tournamnet \"#{m[1]}\" exists."
  end
end

$tournament_start_command = Proc.new do |event|
  m = $tournament_start_regex.match(event.content)
  $tournaments[m[1]].start_tournament
  round = $tournaments[m[1]].get_round(0)
  ot = ''
  i = 1
  round.matches.each do |match|
    ot+="#{i}. #{match.to_s}\n"
    i+=1
  end
  ot+="Byes: #{round.byes.join(', ')}" if round.byes != nil && round.byes.length != 0
  event.respond "Started Tournament!\nRound 1:\n#{ot}"
  write_tournament_yaml
end

$tournamnet_match_command = Proc.new do |event|
  m = $tournamnet_match_regex.match(event.content)
  #TODO
end
