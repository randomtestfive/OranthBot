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
