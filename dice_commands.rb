require_relative 'config_loader'
require_relative 'dice.rb'
require_relative 'regexes.rb'

ident = CONFIG['bot']['ident']

$single_roll_command = Proc.new do |event|
  m = $single_roll_regex.match(event.content)
  event.respond "You rolled: #{roll_dice(m[1])}"
end

$multi_roll_command = Proc.new do |event|
  m = $multi_roll_regex.match(event.content)
  event.respond "#{multi_roll(m[1], m[2], m[3])}"
end

$coin_command = Proc.new do |event|
  m = $coin_regex.match(event.content)
  if m[1] == nil
    event.respond "#{rand(2) == 1 ? "heads" : "tails"}"
  else
    s = ''
    t = 0
    m[1].to_i().times do |n|
      f = rand(2)
      t+=f
      s+="#{f == 1 ? "heads " : "tails "}"
    end
    if m[2] == ' t'
      event.respond "You flipped: #{s}\n#{t} heads : #{m[1].to_i-t} tails"
    else
      event.respond "You flipped: #{s}"
    end
  end
end

$roll_command = Proc.new do |event|
  o = super_roll($roll_regex.match(event.content)[1])
  if o[0].length > 1
    s = o[0].to_s.gsub('[','').gsub(']','').gsub(',', ' +')
    event.respond "You rolled: #{s} = #{o[1]}"
  else
    event.respond "You rolled: #{o[1]}"
  end
end
