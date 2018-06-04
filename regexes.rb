# encoding: UTF-8
require 'yaml'
require_relative 'config_loader.rb'

ident = Regexp.quote CONFIG['bot']['ident']

$coin_regex = Regexp.new("#{ident}f(?:lip)?( \\d+( t)?)?".force_encoding("UTF-8"), Regexp::FIXEDENCODING)
$single_roll_regex = Regexp.new("#{ident}((?:d\\d+[ ,]*)+)".force_encoding("UTF-8"), Regexp::FIXEDENCODING)
$multi_roll_regex = Regexp.new("#{ident}(d\\d+) ?[x\\*] ?(\\d+)( t)?".force_encoding("UTF-8"), Regexp::FIXEDENCODING)
$roll_regex = Regexp.new("#{ident}r(?:oll)? ((?:[0-9]*(?:d[0-9]+)*)(?: *\\+ *[0-9]*(?:d[0-9]+)*)*)".force_encoding("UTF-8"), Regexp::FIXEDENCODING)

$tournament_create_regex = Regexp.new("#{ident}t(?:ournamnet)? c(?:reate)? (\\w+)".force_encoding("UTF-8"), Regexp::FIXEDENCODING)
$tournament_join_regex = Regexp.new("#{ident}t(?:ournament)? j(?:oin)? (\\w+)".force_encoding("UTF-8"), Regexp::FIXEDENCODING)
$tournament_add_regex = Regexp.new("#{ident}t(?:ournament)? a(?:dd)? (\\w+) (\\w+)".force_encoding("UTF-8"), Regexp::FIXEDENCODING)
$tournament_remove_regex = Regexp.new("#{ident}t(?:ournament)? r(?:emove)? (\\w+) (\\w+)".force_encoding("UTF-8"), Regexp::FIXEDENCODING)
$tournament_leave_regex = Regexp.new("#{ident}t(?:ournament)? l(?:eave)? (\w+)".force_encoding("UTF-8"), Regexp::FIXEDENCODING)
$tournament_players_regex = Regexp.new("#{ident}t(?:ournament)? p(?:layers)? (\\w+)".force_encoding("UTF-8"), Regexp::FIXEDENCODING)
$tournament_start_regex = Regexp.new("#{ident}t(?:ournament)? s(?:tart)? (\\w+)".force_encoding("UTF-8"), Regexp::FIXEDENCODING)
$tournament_match_regex = Regexp.new("#{ident}t(?:ournament)? m(?:atch)? (\\w+) (\\d+) (\\w+)".force_encoding("UTF-8"), Regexp::FIXEDENCODING)

$poll_create_regex = Regexp.new("/#{ident}p(?:oll)? c(?:reate)? ([\\w ]+),((?:[\\w ]+)(?:,[\\w ]+)+)".force_encoding("UTF-8"), Regexp::FIXEDENCODING)
$poll_vote_regex = Regexp.new("#{ident}p(?:oll)? v(?:ote)? ([\\w ]+)".force_encoding("UTF-8"), Regexp::FIXEDENCODING)
$poll_results_regex = Regexp.new("#{ident}p(?:oll)? r(?:esults)?".force_encoding("UTF-8"), Regexp::FIXEDENCODING)
$poll_info_regex = Regexp.new("#{ident}p(?:oll)? i(?:nfo)?".force_encoding("UTF-8"), Regexp::FIXEDENCODING)

$youtube_url = Regexp.new("(?:https?\\:\\/\\/)?(?:www\\.)?(?:(?:youtube\\.com)|(?:youtu.be))\\/(?:watch\\?v=)((?:[a-z]|[A-Z]|[0-9])*)".force_encoding("UTF-8"), Regexp::FIXEDENCODING)

$music_start_regex = Regexp.new("#{ident}m(?:usic)? p(?:lay)? (.+)".force_encoding("UTF-8"), Regexp::FIXEDENCODING)
$music_summon_regex = Regexp.new("#{ident}m(?:usic)? s(?:ummon)?".force_encoding("UTF-8"), Regexp::FIXEDENCODING)
$music_disconnect_regex = Regexp.new("#{ident}m(?:usic)? d(?:isconnect)?".force_encoding("UTF-8"), Regexp::FIXEDENCODING)

$linker_add_regex = Regexp.new("#{ident}l(?:ink)? a(?:dd)? ((?:.| )+)\\|((?:.| )+)".force_encoding("UTF-8"), Regexp::FIXEDENCODING)
$linker_remove_regex = Regexp.new("#{ident}l(?:ink)? r(?:emove)? ((?:.| )+)".force_encoding("UTF-8"), Regexp::FIXEDENCODING)
$linker_list_regex = Regexp.new("#{ident}l(?:ink)? l(?:ist)?".force_encoding("UTF-8"), Regexp::FIXEDENCODING)

$help_regex = Regexp.new("#{ident}h(?:elp)?( \\w+)?".force_encoding("UTF-8"), Regexp::FIXEDENCODING)
