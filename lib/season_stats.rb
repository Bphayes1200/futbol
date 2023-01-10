require_relative 'calculable'

class SeasonStats < Stats
  include Calculable

  def most_tackles(season_id)
    teams_tackles_hash = Hash.new(0)
    games_list = list_games_by_season(season_id)
  
    @game_teams.each do |row|
      if games_list.include?(row.game_id)
        teams_tackles_hash[row.team_id] += row.tackles.to_i
      end
    end

    highest_tackling_team_id = teams_tackles_hash.max_by{|k,v| v}[0]
    team_id_to_name(highest_tackling_team_id)   
  end 

  def fewest_tackles(season_id)
    teams_tackles_hash = Hash.new(0)
    games_list = list_games_by_season(season_id)

    @game_teams.each do |row|
      if games_list.include?(row.game_id)
        teams_tackles_hash[row.team_id] += row.tackles.to_i
      end
    end
    
    lowest_tackling_team_id = teams_tackles_hash.min_by{|k,v| v}[0]
    team_id_to_name(lowest_tackling_team_id)
  end

  def winningest_coach(season_id)
    wins_hash = Hash.new(0)
    total_games_hash = Hash.new(0)
    games_list = list_games_by_season(season_id)
    @game_teams.each do |row|
      if games_list.include?(row.game_id)
        wins_hash[row.head_coach] += 1 if row.result == "WIN"
        total_games_hash[row.head_coach] += 1 if row.result
      end
    end

    additional_hash = {}
    total_games_hash.each do |key, value|
      wins_hash.each do |key_v, value_v|
        if key == key_v
          percent = (value_v / value.to_f)
          additional_hash[key] = percent
        end
      end
    end
    additional_hash.max_by{|k,v| v}[0]
  end

  def worst_coach(season_id)
    wins_hash = Hash.new(0)
    total_games_hash = Hash.new(0)
    games_list = list_games_by_season(season_id)

    @game_teams.each do |row|
      if games_list.include?(row.game_id)
        wins_hash[row.head_coach] += 1 if row.result == "WIN"
        wins_hash[row.head_coach] += 0 if row.result
        total_games_hash[row.head_coach] += 1 if row.result
      end
    end

    additional_hash = {}
    total_games_hash.each do |key, value|
      wins_hash.each do |key_v, value_v|
        if key == key_v
          percent = (value_v / value.to_f)
          additional_hash[key] = percent
        end
      end
    end
    additional_hash.min_by{|k,v| v}[0]
  end

  def teams_by_accuracy(season)
    games_for_season = @games.find_all do |game|
      game.season == season
    end
    game_ids = games_for_season.map do |game|
      game.game_id
    end
    games_teams_for_season = @game_teams.find_all do |game_team|
     game_ids.include?(game_team.game_id)
    end
    games_grouped_by_team = games_teams_for_season.group_by do |game_team|
      game_team.team_id
    end
    ratios_grouped_by_team = games_grouped_by_team.map do |team_id, game_teams|
      goals = game_teams.sum {|game_team| game_team.goals.to_i} 
      shots=  game_teams.sum {|game_team| game_team.shots.to_i}
      ratio = goals/shots.to_f
      {team_id =>ratio}
    end
  end
  
  def most_accurate_team(season)
    team_id = teams_by_accuracy(season).max_by do |team_ratio|
  
      team_ratio.values
  
    end.keys.first
  
    team = @teams.find do |team|
      team_id == team.team_id
    end
    team.team_name
  end
  
  def least_accurate_team(season)
    team_id = teams_by_accuracy(season).min_by do |team_ratio|
      team_ratio.values
    end.keys.first
  
    team = @teams.find do |team|
    team_id == team.team_id
    end
    team.team_name
    end
end