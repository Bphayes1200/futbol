require './spec_helper'
require './lib/stat_tracker'
RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/fake_games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/fake_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it "exists" do
    expect(@stat_tracker).to be_an_instance_of StatTracker
  end


  it 'can calculate the average goals per game' do 
    expect(@stat_tracker.average_goals_per_game).to eq(3.4)
  end

  it 'will calculate the average goals per game by season' do 
    # expect(@stat_tracker.average_goals_by_season).to be_a(Hash)
    expect(@stat_tracker.average_goals_by_season["20122013"]).to eq(4)
  end

  it 'counts the number of games by season' do
    expect(@stat_tracker.count_of_games_by_season).to eq({

      "20122013"=> 2, 
      "20142015" => 2, 
      "20132014" => 1
    })  
  end

  it "calculates home win %" do
  #require 'pry'; binding.pry
    expect(@stat_tracker.percentage_home_wins).to eq 0.45
  end

  it 'calculates visitor win %' do
    expect(@stat_tracker.percentage_visitor_wins).to eq 0.47
  end

  it 'calculates percent of ties' do
    expect(@stat_tracker.percentage_ties).to eq 0.08
  end

  it 'names winningest coach of the season' do
    
    expect(@stat_tracker.winningest_coach("20122013")).to eq("Claude Julien")
  end
  
  it 'will calculate the highest scoring visitor' do 
    expect(@stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
  end

  it 'will calculate the lowest scoring visitor' do 
    expect(@stat_tracker.lowest_scoring_visitor).to eq("FC Dallas")
  end

  it 'will calculate the highest scoring home team' do 
    expect(@stat_tracker.highest_scoring_home_team).to eq("Montreal Impact")
  end
  it 'will calculate the lowest scoring home team' do 
    expect(@stat_tracker.lowest_scoring_home_team).to eq("Montreal Impact")
  end

  xit 'will calculate the worst coach' do
    
    expect(@stat_tracker.worst_coach("20122013")).to eq("name")
  end

  it 'will calculate average win percentage' do
    expect(@stat_tracker.average_win_percentage("6")).to eq 1.0
    expect(@stat_tracker.average_win_percentage("15")).to eq 0.38
  end
end