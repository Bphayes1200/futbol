require_relative 'calculable'

class TeamStats < Stats
  include Calculable

  def team_info(team_id)
    info = @teams.find {|team| team.team_id == team_id}
    { 'team_id' => info.team_id, 'franchise_id' => info.franchise_id, 'team_name' => info.team_name, 'abbreviation' => info.abbreviation, 'link' => info.link }
  end

  def best_season(team_id)
    games_won_and_played_hash = nested_hash_creator
    chosen_teams_games = @game_teams.find_all {|game| game.team_id == team_id }
    chosen_teams_games.each do |game|
      @games.each do |row|
        if game.game_id == row.game_id && game.result == 'WIN'
        games_won_and_played_hash[row.season]['wins'] += 1 
        elsif game.game_id == row.game_id
        games_won_and_played_hash[row.season]['not wins'] += 1
        end
      end
    end
    win_percents_by_season = games_won_and_played_hash.map do |key, value|
      [key, value["wins"].to_f / (value["wins"].to_f + value["not wins"].to_f )]
    end  
    win_percents_by_season.max_by{|k,v| v}[0]
  end

  def worst_season(team_id)
    games_won_and_played_hash = nested_hash_creator
    chosen_teams_games = @game_teams.find_all {|game| game.team_id == team_id }
    chosen_teams_games.each do |game|
      @games.each do |row|
        if game.game_id == row.game_id && game.result == 'WIN'
        games_won_and_played_hash[row.season]['wins'] += 1 
        elsif game.game_id == row.game_id
        games_won_and_played_hash[row.season]['not wins'] += 1
        end
      end
    end
    win_percents_by_season = games_won_and_played_hash.map do |key, value|
      [key, value["wins"].to_f / (value["wins"].to_f + value["not wins"].to_f )]
    end  
    win_percents_by_season.min_by{|k,v| v}[0]
  end

  def average_win_percentage(team_id)
    games_by_team = @game_teams.find_all {|game| game.team_id == team_id}
    total = games_by_team.count
    wins = 0
    games_by_team.each do |game|
      wins += 1 if game.result == "WIN"
    end
    (wins/total.to_f).round(2)
  end

  def favorite_opponent(team_id)
    all_wins = @game_teams.find_all { |game| game[:team_id] == team_id && game[:result] == "WIN"}
    all_games = @games.find_all { |game| game[:home_team_id] == team_id || game[:away_team_id] == team_id} 
    all_game_ids = all_wins.map {|game| game[:game_id]}

    all_games_opposing_team_ids = []
      all_games.each do |game| 
        if team_id == game[:home_team_id]
          all_games_opposing_team_ids << game[:away_team_id]
        else 
          all_games_opposing_team_ids << game[:home_team_id]
        end
      end

    all_games_hash = all_games_opposing_team_ids.tally

    all_games = []
    all_game_ids.each do |game_id|
      @games.each do |game| 
        if game_id == game[:game_id]
          all_games << game 
        end
      end 
    end 

    opposing_team_ids = []
      all_games.each do |game| 
        if team_id == game[:home_team_id]
          opposing_team_ids << game[:away_team_id]
        else 
          opposing_team_ids << game[:home_team_id]
        end
      end

    id_hash = opposing_team_ids.tally

    final_breakdown = {}
    id_hash.each do |id, value| 
      all_games_hash.each do |game, games_value|
        if id == game
          final_breakdown[id] = (value.to_f / games_value.to_f).round(3)
        end
      end
    end
    favorite_opponent_id = nil
    final_breakdown.select { |id, win_percentage| favorite_opponent_id = id if win_percentage == final_breakdown.values.max}

    team_id_to_name(favorite_opponent_id)
  end

  def rival(team_id)
    all_losses = @game_teams.find_all { |game| game.team_id == team_id && game.result == "LOSS"}
    all_games = @games.find_all { |game| game.home_team_id == team_id || game.away_team_id == team_id} 
    all_game_ids = all_losses.map {|game| game.game_id}

    all_games_opposing_team_ids = []
      all_games.each do |game| 
        if team_id == game.home_team_id
          all_games_opposing_team_ids << game.away_team_id
        else 
          all_games_opposing_team_ids << game.home_team_id
        end
      end

    all_games_hash = all_games_opposing_team_ids.tally

    all_games = []
    all_game_ids.each do |game_id|
      @games.each do |game| 
        if game_id == game.game_id
          all_games << game 
        end
      end 
    end 

    opposing_team_ids = []
      all_games.each do |game| 
        if team_id == game.home_team_id
          opposing_team_ids << game.away_team_id
        else 
          opposing_team_ids << game.home_team_id
        end
      end

    id_hash = opposing_team_ids.tally

    final_breakdown = {}
    id_hash.each do |id, value| 
      all_games_hash.each do |game, games_value|
        if id == game
          final_breakdown[id] = (value.to_f / games_value.to_f).round(3)
        end
      end
    end
    favorite_opponent_id = nil
    final_breakdown.select { |id, win_percentage| favorite_opponent_id = id if win_percentage == final_breakdown.values.max}

    team_id_to_name(favorite_opponent_id)
  end
   
  def most_goals_scored(team_id)
    sorted_list = {}
    teamid = @game_teams.find_all do |game|
      game.team_id == team_id
    end
     most_goals = teamid.map do |game|
        game.goals
    end
    most_goals.max.to_i
  end

  def fewest_goals_scored(team_id)
    sorted_list = {}
    teamid = @game_teams.find_all do |game|
      game.team_id == team_id
    end
     most_goals = teamid.map do |game|
        game.goals
    end
    most_goals.min.to_i
  end
end