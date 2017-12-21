require 'json'
require 'yaml'
require 'gruff'
require_relative 'regexes.rb'

class Poll
  attr_accessor :title
  attr_accessor :options
  attr_accessor :votes
  def initialize title, options
    self.title = title
    self.options = options
    self.votes = Hash.new
  end

  def vote user, choice
    if self.options.include? choice
      self.votes[user] = choice
      true
    else
      false
    end
  end

  def count_votes
    v = Hash.new
    votes.each do |user, option|
      v[option] = 0 if v[option] == nil
      v[option] = v[option] + 1
    end
    v
  end

  def create_image
    g = Gruff::Pie.new
    g.theme = Gruff::Themes::PASTEL
    g.title = self.title
    v = count_votes
    v.each do |choice, count|
      g.data choice.to_s, [count]
    end
    g.write('poll.png')
  end
end

$poll = nil
if File.exists? 'poll.yml'
  $poll = YAML.load_file('poll.yml')
end

$poll_create = Proc.new do |event|
  m = $poll_create_regex.match(event.content)
  title = m[1]
  options = m[2].split ','
  options.each do |option|
    option.strip!
  end
  $poll = Poll.new title, options
  event.respond "Created poll #{title}"
  File.write('poll.yml', $poll.to_yaml)
end

$poll_vote = Proc.new do |event|
  m = $poll_vote_regex.match(event.content)
  if $poll != nil
    if $poll.vote(event.user.name, m[1])
      File.write('poll.yml', $poll.to_yaml)
      event.respond "Voted for \"#{m[1]}\"."
    else
      event.respond "Option \"#{m[1]}\" does not exist."
    end
  else
    event.respond 'No poll exists.'
  end
end

$poll_results = Proc.new do |event|
  if $poll != nil
    $poll.create_image
    event.channel.send_file(File.open("poll.png"))
  else
    event.respond 'No poll exists.'
  end
end

$poll_info = Proc.new do |event|
  r = ''
  v = $poll.count_votes
  $poll.options.each do |o|
    r += "#{o} : #{v[o] == nil ? '0' : v[o]}\n"
  end
  event.respond "Current Poll: #{$poll.title}\n```\n#{r}```"
end
