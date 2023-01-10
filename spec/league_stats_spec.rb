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

    @league_stats = LeagueStats.new(data)
  end 

  it 'counts the number of teams' do 
    expect(@league_stats.count_of_teams).to eq(32)
  end

  it "it can find the team with the highest average number of goals scored per game" do
    expect(@stat_tracker.best_offense).to eq("Chicago Fire")
  end

  it "it can find the team with the lowest average number of goals scored per game" do
    expect(@stat_tracker.worst_offense).to eq("Minnesota United FC")
  end

  it 'will calculate the highest scoring visitor' do 
    expect(@stat_tracker.highest_scoring_visitor).to eq("Sporting Kansas City")
  end

  it 'will calculate the lowest scoring visitor' do 
    expect(@stat_tracker.lowest_scoring_visitor).to eq("Columbus Crew SC")
  end

  it 'will calculate the highest scoring home team' do 
    expect(@stat_tracker.highest_scoring_home_team).to eq("Seattle Sounders FC")
  end
  it 'will calculate the lowest scoring home team' do 
    expect(@stat_tracker.lowest_scoring_home_team).to eq("Minnesota United FC")
  end
end 