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
end