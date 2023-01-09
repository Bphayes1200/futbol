require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'

class Stats
  attr_reader :data_array,
              :games,
              :teams,
              :game_teams

              