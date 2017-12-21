class Matchup < Struct.new(:one, :two, :winner)
  def to_s
    if self.winner == 0
      "#{self.one} vs #{self.two}"
    elsif self.winner == 1
      "#{self.one} (winner) vs #{self.two}"
    else
      "#{self.one} vs #{self.two} (winner)"
    end
  end
end

class Round < Struct.new(:matches, :byes)
  def initialize
    self.matches = []
    self.byes = []
  end
end

def nearest_power_2 n
  l = 0
  while 2 ** l < n do
    l+=1
  end
  2 ** l
end

class Tournament

  def initialize(arr)
    @players_start = arr[0..-1]
    @started = false
    @current_round = 0
  end

  def initialize
    @players_start = []
    @started = false
    @current_round = 0
  end

  def started?
    @started
  end

  def players_start
    @players_start
  end

  def add_player player
    @players_start << player unless @players_start.include? player
  end

  def remove_player player
    @players_start.delete player
  end

  def start_tournament
    @current_round = 0
    @started = true
    @players = @players_start[0..-1]
    @players.shuffle!
    if @players.length != nearest_power_2(@players.length)
      byes = @players.slice(0..(nearest_power_2(@players.length) - @players.length - 1))
    end
    @rounds = []
    generate_round
    @rounds[0].byes = byes
  end

  def next_round
    m = get_current_round.matches
    m.each do |match|
      @players.delete(match.winner == 1 ? match.two : match.one)
    end
    generate_round
    @current_round+=1
  end

  def generate_round
    round = Round.new
    (@players.length-1).times do |n|
      if n % 2 == 0
        round.matches.push Matchup.new(@players[n], @players[n+1], 0)
      end
    end
    @rounds << round
  end

  def decide_match(m, w)
    match = get_current_round.matches[m]
    if w == match.one
      match.winner = 1
    else
      match.winner = 2
    end
  end

  def check_round_complete
    #TODO do this next
  end

  def check_tournament_over
    @players.length == 1
  end


  def get_round n
    @rounds[n]
  end

  def get_current_round
    @rounds[@current_round]
  end
end
