# encoding: UTF-8
require 'yaml'
require_relative 'config_loader.rb'

ident = Regexp.quote CONFIG['bot']['ident']

$coin_regex = /#{ident}f(?:lip)?( \d+( t)?)?/u
$single_roll_regex = /#{ident}((?:d\d+[ ,]*)+)/u
$multi_roll_regex = /#{ident}(d\d+) ?[x\*] ?(\d+)( t)?/u

$tournament_create_regex = /#{ident}t(?:ournamnet)? c(?:reate)? (\w+)/u
$tournament_join_regex = /#{ident}t(?:ournament)? j(?:oin)? (\w+)/u
$tournament_add_regex = /#{ident}t(?:ournament)? a(?:dd)? (\w+) (\w+)/u
$tournament_remove_regex = /#{ident}t(?:ournament)? r(?:emove)? (\w+) (\w+)/u
$tournament_leave_regex = /#{ident}t(?:ournament)? l(?:eave)? (\w+)/u
$tournament_players_regex = /#{ident}t(?:ournament)? p(?:layers)? (\w+)/u
$tournament_start_regex = /#{ident}t(?:ournament)? s(?:tart)? (\w+)/u
$tournament_match_regex = /#{ident}t(?:ournament)? m(?:atch)? (\w+) (\d+) (\w+)/u

$poll_create_regex = /#{ident}p(?:oll)? c(?:reate)? ([\w ]+),((?:[\w ]+)(?:,[\w ]+)+)/u
$poll_vote_regex = /#{ident}p(?:oll)? v(?:ote)? ([\w ]+)/u
$poll_results_regex = /#{ident}p(?:oll)? r(?:esults)?/u
$poll_info_regex = /#{ident}p(?:oll)? i(?:nfo)?/u

$youtube_url = /(?:https?\:\/\/)?(?:www\.)?(?:(?:youtube\.com)|(?:youtu.be))\/(?:watch\?v=)((?:[a-z]|[A-Z]|[0-9])*)/u

$music_start_regex = /#{ident}m(?:usic)? p(?:lay)? (.+)/u
$music_summon_regex = /#{ident}m(?:usic)? s(?:ummon)?/u
$music_disconnect_regex = /#{ident}m(?:usic)? d(?:isconnect)?/u

$linker_add_regex = /#{ident}l(?:ink)? a(?:dd)? ((?:.| )+)\|((?:.| )+)/u
$linker_remove_regex = /#{ident}l(?:ink)? r(?:emove) ((?:.| )+)/u

$help_regex = /#{ident}h(?:elp)?( \w+)?/u
