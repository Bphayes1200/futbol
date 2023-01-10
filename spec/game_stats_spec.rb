require 'csv'
require_relative 'spec_helper'
require './lib/game_stats'
require './lib/game'
require './lib/team'
require './lib/game_teams'
require './lib/stat_tracker'

RSpec.describe StatTracker do
  before(:all) do

    data = { 
      games: './data/sample_games.csv',
      teams: './data/teams.csv',
      game_teams: './data/sample_game_teams.csv'
    }

    @stat_tracker = StatTracker.from_csv(data)

    @game_stats = GameStats.new(data)
  end

  it "exists" do
  end

  it "can calculate the highest total score by both teams in a game" do
    expect(@stat_tracker.highest_total_score).to eq(7)
  end

  it "can calculate the lowest total score by both teams in a game" do
    expect(@stat_tracker.lowest_total_score).to eq(1)
  end

  it "calculates home win %" do
    expect(@stat_tracker.percentage_home_wins).to eq 0.48
  end

  it 'calculates visitor win %' do
    expect(@stat_tracker.percentage_visitor_wins).to eq 0.32
  end

  it 'calculates percent of ties' do
    expect(@stat_tracker.percentage_ties).to eq 0.19
  end

  it 'counts the number of games by season' do
    expect(@stat_tracker.count_of_games_by_season).to eq({

      "20122013"=>10, 
      "20132014"=>10, 
      "20142015"=>10
      
    })  
  end

  it 'can calculate the average goals per game' do 
    expect(@stat_tracker.average_goals_per_game).to eq(4.3)
  end

  it 'will calculate the average goals per game by season' do 
    expect(@stat_tracker.average_goals_by_season["20122013"]).to eq(4.5)
  end
end


