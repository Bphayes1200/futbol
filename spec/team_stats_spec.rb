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
    @team_stats = TeamStats.new(data)
  end
    
  it 'will display team info' do
    expected = {
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18"
      }
    expect(@stat_tracker.team_info("18")).to eq expected
  end

  it "exists" do
    expect(@team_stats).to be_an_instance_of(TeamStats)
  end
  
  it "can calculate the season with the highest win percentage for a team" do
    expect(@stat_tracker.best_season("4")).to eq("20142015")
  end

  it "can calculate the season with the lowest win percentage for a team" do
    expect(@stat_tracker.worst_season("4")).to eq("20132014")
  end

  it "can find the highest number of goals a team has scored in one game" do
    expect(@stat_tracker.most_goals_scored("18")).to eq 0
    expect(@stat_tracker.most_goals_scored("10")).to eq 2
  end

  it "can find the lowest number of goals a team has scored in one game" do
   expect(@stat_tracker.fewest_goals_scored("18")).to eq 0
    expect(@stat_tracker.fewest_goals_scored("1")).to eq 1
  end

  it 'will find a teams favorite opponenet' do 
    expect(@stat_tracker.favorite_opponent("7")).to eq("Sporting Kansas City")
  end

  it 'will find a teams rival' do 
    expect(@stat_tracker.rival("22")).to eq("Houston Dash")
  end
end