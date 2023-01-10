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

  it 'names winningest coach of the season' do
    expect(@stat_tracker.winningest_coach("20132014")).to eq("Lindy Ruff")
    expect(@stat_tracker.winningest_coach("20122013")).to eq("Joel Quenneville")
  end

  it 'will calculate the worst coach' do
    expect(@stat_tracker.worst_coach("20122013")).to eq("Bob Hartley")
    expect(@stat_tracker.worst_coach("20132014")).to eq("Craig Berube")
  end

  it "find the team with the best shot ratio in a season" do
    expect(@stat_tracker.most_accurate_team("20132014")).to eq("Toronto FC")
  end

  it "find the team with the worst shot ratio in a season" do
    expect(@stat_tracker.least_accurate_team("20132014")).to eq("Minnesota United FC")
  end

  it "find the name of the team with the most tackles in a season" do
    expect(@stat_tracker.most_tackles("20132014")).to eq ("Houston Dash")
  end

  it "find the name of the team with the least tackles in a season" do
    expect(@stat_tracker.fewest_tackles("20132014")).to eq("Atlanta United")
  end
end