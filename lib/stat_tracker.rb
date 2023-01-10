require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_teams'
require_relative 'stats_initialize'
require_relative 'game_stats'
require_relative 'team_stats'
require_relative 'league_stats'
require_relative 'season_stats'

class StatTracker
  attr_reader :game_stats,
              :team_stats,
              :league_stats,
              :season_stats

  def self.from_csv(locations)
    @stat_tracker = StatTracker.new(info)
  end

  def initialize(info)
    @game_stats   = GameStats.new(info)
    @team_stats   = TeamStats.new(info)
    @league_stats = LeagueStats.new(info)
    @season_stats = SeasonStats.new(info)
  end
end










