# encoding: UTF-8

require 'discordrb'
require_relative 'config_loader.rb'
require_relative 'dice.rb'
require_relative 'dice_commands.rb'
require_relative 'tournament.rb'
require_relative 'regexes.rb'
require_relative 'help.rb'
require_relative 'tournament_commands.rb'
require_relative 'poll.rb'
require_relative 'youtube_commands.rb'
require_relative 'linker_commands.rb'

bot = Discordrb::Bot.new token: CONFIG['discord']['token'], client_id: CONFIG['discord']['client_id']

ident = CONFIG['bot']['ident']

bot.message(with_text: $single_roll_regex) { |event| $single_roll_command.call(event) }
bot.message(with_text: $multi_roll_regex) { |event| $multi_roll_command.call(event) }
bot.message(with_text: $coin_regex) { |event| $coin_command.call(event) }

bot.message(with_text: $tournament_create_regex) { |event| $tournament_create_command.call(event) }
bot.message(with_text: $tournament_join_regex) { |event| $tournament_join_command.call(event) }
bot.message(with_text: $tournament_add_regex) { |event| $tournament_add_command.call(event) }
bot.message(with_text: $tournament_remove_regex) { |event| $tournament_remove_command.call(event) }
bot.message(with_text: $tournament_leave_regex) { |event| $tournament_leave_command.call(event) }
bot.message(with_text: $tournament_players_regex) { |event| $tournament_players_command.call(event) }
bot.message(with_text: $tournament_start_regex) { |event| $tournament_start_command.call(event) }

bot.message(with_text: $poll_create_regex) { |event| $poll_create.call(event) }
bot.message(with_text: $poll_vote_regex) { |event| $poll_vote.call(event) }
bot.message(with_text: $poll_results_regex) { |event| $poll_results.call(event) }
bot.message(with_text: $poll_info_regex) { |event| $poll_info.call(event) }

bot.message(with_text: $music_start_regex) { |event| $music_start_command.call(event) }
bot.message(with_text: $music_summon_regex) { |event| $music_summon_command.call(event,bot) }
bot.message(with_text: $music_disconnect_regex) { |event| event.voice.destroy }

bot.message(with_text: $linker_add_regex) { |event| $linker_add_command.call(event) }

bot.message(with_text: $help_regex) { |event| $help_command.call(event) }

bot.message { |event| $linker_find_match.call(event) }

bot.run
