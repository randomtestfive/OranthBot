require_relative 'config_loader'
require_relative 'regexes.rb'

ident = CONFIG['bot']['ident']

$help_command = Proc.new do |event|
  m = $help_regex.match event.content
  puts m[1]
  if m[1] == nil
    event.respond "Commands:
    `#{ident}h(elp) (command)`: Display this help or more specific help.
    `#{ident}d#`: Roll a d#.
    `#{ident}f(lip)`: Flip a coin.
    `#{ident}t(ournamnet)`: Tournament command.
    `#{ident}p(oll)`: Poll command.
    `#{ident}l(ink)`: Link command.
    `#{ident}latex`: create latex"
  elsif / t(ournament)?/.match(m[1]) != nil
    event.respond "Tournament commands:
    `#{ident}t(ournament) c(reate) (tournament)`: Create a tournament. [Admin]
    `#{ident}t j(oin) (tournament)`: Join a tournament.
    `#{ident}t a(dd) (name) (tournament)`: Add a name to a tournament. [Admin]
    `#{ident}t l(eave) (tournament)`: Leave a tournament.
    `#{ident}t r(emove) (name) (tournament)`: Remove a name from a tournament. [Admin]
    `#{ident}t p(layers) (tournament)`: List the players in a tournament.
    `#{ident}t s(start) (tournament)`: Start a tournament. [Admin]"
  elsif / d/.match(m[1]) != nil || / f(lip)?/.match(m[1]) != nil
    event.respond "Dice/Coin commands:
    `#{ident}d#, d#, d# ...`: Roll a specific set of d#s. (eg. `!d20 d6 d4`)
    `#{ident}d# (x Amount) (t)`: Roll a number of d#s. Add `t` to display the total.
    `#{ident}f (Amount) (t)`: Flip a number of coins. Add `t` to display the total."
  elsif / p(oll)?/.match(m[1]) != nil
    event.respond "Poll commands:
    `#{ident}p(oll) c(reate) (name),(opt 1, opt 2, opt 3...)`: Create a poll. [Admin]
    `#{ident}p v(ote) (option)`: Vote for an option in a poll.
    `#{ident}p i(nfo)`: Show information about the current poll.
    `#{ident}p r(esults)`: Display the current results."
  elsif / l(ink)?/.match(m[1]) != nil
    event.respond "Link commands:
    `#{ident}l(ink) a(dd) (key)|(value)`: Create a link.
    `#{ident}l r(emove) (key)`: Remove a link.
    `#{ident}l l(ist)`: List all links."
  else
    event.respond "Unknown subcommand."
  end
end
