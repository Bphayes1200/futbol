require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_teams'
require_relative 'stat_initialize'
require_relative 'game_stats'
require_relative 'team_stats'
require_relative 'league_stats'
require_relative 'season_stats'

class StatTracker
  attr_reader :game_stats,
              :team_stats,
              :league_stats,
              :season_stats

  def self.from_csv(data)
    @stat_tracker = StatTracker.new(data)
  end

  def initialize(data)
    @game_stats   = GameStats.new(data)
    @team_stats   = TeamStats.new(data)
    @league_stats = LeagueStats.new(data)
    @season_stats = SeasonStats.new(data)
  end

  def highest_total_score
    @game_stats.highest_total_score
  end
end










