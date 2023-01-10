require './spec_helper'
require './lib/stat_tracker'

RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/sample_games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/sample_game_teams.csv'

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






  it 'names winningest coach of the season' do
    expect(@stat_tracker.winningest_coach("20132014")).to eq("Lindy Ruff")
    expect(@stat_tracker.winningest_coach("20122013")).to eq("Joel Quenneville")
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

  it 'will calculate the lowest scoring home team' do 
    expect(@stat_tracker.lowest_scoring_home_team).to eq("Minnesota United FC")
  end

  it 'will calculate the worst coach' do
    expect(@stat_tracker.worst_coach("20122013")).to eq("Bob Hartley")
    expect(@stat_tracker.worst_coach("20132014")).to eq("Craig Berube")
  end

  it 'will calculate average win percentage' do
    expect(@stat_tracker.average_win_percentage("6")).to eq 1.0
    expect(@stat_tracker.average_win_percentage("25")).to eq 0.4
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
  
  it "can calculate the season with the highest win percentage for a team" do
    expect(@stat_tracker.best_season("4")).to eq("20142015")
  end

  it "can calculate the season with the lowest win percentage for a team" do
    expect(@stat_tracker.worst_season("4")).to eq("20132014")
  end

  it 'will find a teams favorite opponenet' do 
    expect(@stat_tracker.favorite_opponent("7")).to eq("Sporting Kansas City")
  end

  it 'will find a teams rival' do 
    expect(@stat_tracker.rival("22")).to eq("Houston Dash")
  end

  it "can find the highest number of goals a team has scored in one game" do
    expect(@stat_tracker.most_goals_scored("18")).to eq 0
    expect(@stat_tracker.most_goals_scored("10")).to eq 2
  end

  it "can find the lowest number of goals a team has scored in one game" do
    expect(@stat_tracker.fewest_goals_scored("18")).to eq 0
    expect(@stat_tracker.fewest_goals_scored("1")).to eq 1
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

  it "it can find the team with the highest average number of goals scored per game" do
    expect(@stat_tracker.best_offense).to eq("Chicago Fire")
  end

  it "it can find the team with the lowest average number of goals scored per game" do
    expect(@stat_tracker.worst_offense).to eq("Minnesota United FC")
  end
end