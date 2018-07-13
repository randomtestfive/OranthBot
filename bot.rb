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
require_relative 'meme_commands.rb'

bot = Discordrb::Bot.new token: CONFIG['discord']['token'], client_id: CONFIG['discord']['client_id']

ident = CONFIG['bot']['ident']

bot.message(with_text: $single_roll_regex) { |event| $single_roll_command.call(event) }
bot.message(with_text: $multi_roll_regex) { |event| $multi_roll_command.call(event) }
bot.message(with_text: $coin_regex) { |event| $coin_command.call(event) }
bot.message(with_text: $roll_regex) { |event| $roll_command.call(event) }

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
bot.message(with_text: $linker_remove_regex) { |event| $linker_remove_command.call(event) }
bot.message(with_text: $linker_list_regex) { |event| $linker_list_command.call(event) }

bot.message(with_text: $meme_create_regex) { |event| $meme_create_command.call(event) }
bot.message(with_text: $meme_list_regex) { |event| $meme_list_command.call(event) }

bot.message(with_text: $help_regex) { |event| $help_command.call(event) }

bot.message(with_text: 'test') do |event|
  event.channel.send_embed do |embed|
    embed.color = 0xFF0000
    embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: 'OranthBot', icon_url: 'https://www.ruby-lang.org/images/header-ruby-logo.png')
    embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new url: 'https://cdn.discordapp.com/embed/avatars/0.png'
    embed.add_field(name: "methods", value: '```'+embed.methods.sort.to_s+'```', inline: true)
    embed.add_field(name: "thing 2", value: "another something", inline: true)
    embed.add_field(name: "smolboy", value: ":)", inline: true)
    embed.footer = Discordrb::Webhooks::EmbedFooter.new text: 'footer'
  end
end

bot.message { |event| $linker_find_match.call(event) }

bot.run
