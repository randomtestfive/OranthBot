def roll_die num
  1+rand(num)
end

def roll_dice s
  s.tr!(', ','')
  dice = s.split('d')
  dice.shift if dice[0] == ''
  o = ""
  dice.each do |die|
    o+= "#{roll_die(die.to_i)} "
  end
  o
end

def multi_roll(d, a, t)
  s = d * a.to_i
  if t != ' t'
    "You rolled: #{roll_dice(s)}"
  else
    s2 = roll_dice(s)
    dice = s2.split
    t = 0
    dice.each do |d|
      t+=d.to_i
    end
    "You rolled: #{s2}\ntotal: #{t}"
  end
end

def resolve_single(s)
  i = s.index('d')
  if i == nil
    return [s.to_i]
  elsif i == 0
    return [roll_die(s[1..-1].to_i)]
  else
    o = []
    s[0..(i-1)].to_i.times do |frea|
      o.push roll_die(s[(i+1)..-1].to_i)
    end
    return o
  end
end

def super_roll(s)
  dice = s.split '+'
  dice.map { |die| die.tr(' ', '') }
  sum = 0
  all = []
  dice.each do |die|
    all.concat resolve_single die
  end
  [all, all.reduce(:+)]
end
