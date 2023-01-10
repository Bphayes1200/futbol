require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'

class Stats
  attr_reader :games,
              :teams,
              :game_teams
  def initialize(data)
    @games = CSV.read(data[:games], headers: true, header_converters: :symbol).map{|game| Game.new(game)}
    @teams = CSV.read(data[:teams], headers: true, header_converters: :symbol).map{|team| Team.new(team)}
    @game_teams = CSV.read(data[:game_teams], headers: true, header_converters: :symbol).map{|game_team| GameTeam.new(game_team)}
  end
end
              