require './lib/stat_tracker'

RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/fake_games.csv'
    team_path = './data/fake_teams.csv'
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

    #   "20122013"=>806,
    #   "20162017"=>1317,
    #   "20142015"=>1319,
    #   "20152016"=>1321,
    #   "20132014"=>1323,
    #   "20172018"=>1355
    # }) 
    # expect(@stat_tracker.count_of_games_by_season(20122013)).to eq(6)
  end

  it "calculates home win %" do
  #require 'pry'; binding.pry
    expect(@stat_tracker.percentage_home_wins).to eq 0.60
  end

  it 'calculates visitor win %' do
    expect(@stat_tracker.percentage_visitor_wins).to eq 0.40
  end

  it 'calculates percent of ties' do
    expect(@stat_tracker.percentage_ties).to eq 0.0
  end
end