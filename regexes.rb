require 'yaml'
require_relative 'config_loader.rb'

ident = Regexp.quote CONFIG['bot']['ident']

$coin_regex = /#{ident}f(?:lip)?( \d+( t)?)?/
$single_roll_regex = /#{ident}((?:d\d+[ ,]*)+)/
$multi_roll_regex = /#{ident}(d\d+) ?[x\*] ?(\d+)( t)?/

$tournament_create_regex = /#{ident}t(?:ournamnet)? c(?:reate)? (\w+)/
$tournament_join_regex = /#{ident}t(?:ournament)? j(?:oin)? (\w+)/
$tournament_add_regex = /#{ident}t(?:ournament)? a(?:dd)? (\w+) (\w+)/
$tournament_remove_regex = /#{ident}t(?:ournament)? r(?:emove)? (\w+) (\w+)/
$tournament_leave_regex = /#{ident}t(?:ournament)? l(?:eave)? (\w+)/
$tournament_players_regex = /#{ident}t(?:ournament)? p(?:layers)? (\w+)/
$tournament_start_regex = /#{ident}t(?:ournament)? s(?:tart)? (\w+)/
$tournament_match_regex = /#{ident}t(?:ournament)? m(?:atch)? (\w+) (\d+) (\w+)/

$poll_create_regex = /#{ident}p(?:oll)? c(?:reate)? ([\w ]+),((?:[\w ]+)(?:,[\w ]+)+)/
$poll_vote_regex = /#{ident}p(?:oll)? v(?:ote)? ([\w ]+)/
$poll_results_regex = /#{ident}p(?:oll)? r(?:esults)?/
$poll_info_regex = /#{ident}p(?:oll)? i(?:nfo)?/

$youtube_url = /(?:https?\:\/\/)?(?:www\.)?(?:(?:youtube\.com)|(?:youtu.be))\/(?:watch\?v=)((?:[a-z]|[A-Z]|[0-9])*)/

$music_start_regex = /#{ident}m(?:usic)? p(?:lay)? (.+)/
$music_summon_regex = /#{ident}m(?:usic)? s(?:ummon)?/
$music_disconnect_regex = /#{ident}m(?:usic)? d(?:isconnect)?/

$help_regex = /#{ident}h(?:elp)?( \w+)?/
