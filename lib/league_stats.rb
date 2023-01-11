require_relative 'calculable'

class LeagueStats < Stats
  include Calculable 

  def count_of_teams
    @teams.count
  end

  def best_offense
    hash1 = nested_hash_creator
    hash2 = Hash.new(0)
    game_teams.each do |row|
      hash1[row.team_id][:games] += 1
      hash1[row.team_id][:goals] += row.goals.to_i
    end
    hash1.each do |key, value|
      hash2[key] =  value[:goals].to_f / value[:games].to_f
    end
    highest_goals_average = hash2.values.max
    highest_scoring_id = hash2.find do |key, value|
      value == highest_goals_average
    end[0]
    team_id_to_name(highest_scoring_id)
  end

  def worst_offense
    hash1 = nested_hash_creator
    hash2 = Hash.new(0)
    game_teams.each do |row|
      hash1[row.team_id][:games] += 1
      hash1[row.team_id][:goals] += row.goals.to_i
    end
    hash1.each do |key, value|
      hash2[key] =  value[:goals].to_f / value[:games].to_f
    end
    lowest_goals_average = hash2.values.min
    lowest_scoring_id = hash2.find do |key, value|
      value == lowest_goals_average
    end[0]
    team_id_to_name(lowest_scoring_id)
  end

  def highest_scoring_visitor
    scoring_breakdown = {}
    teams = @teams.map { |team| team.team_id }
    teams.each do |team|
      all_away_games = @games.find_all { |game| game.away_team_id == team}
        total_goals = all_away_games.map { |away_game| away_game.away_goals.to_i}.sum
        if all_away_games.count != 0
        average_away_goals = total_goals.to_f / all_away_games.count.to_f
        scoring_breakdown[team] = average_away_goals.to_f.round(2)
        else 
          nil
        end 
    end 
    leading_team_id = nil
    scoring_breakdown.each { |key, value| leading_team_id = key if  value == scoring_breakdown.values.max }
    team_id_to_name(leading_team_id)
  end

  def lowest_scoring_visitor 
    scoring_breakdown = {}
    teams = @teams.map { |team| team.team_id }
    teams.each do |team|
      all_away_games = @games.find_all { |game| game.away_team_id == team}
      total_goals = all_away_games.map { |away_game| away_game.away_goals.to_i}.sum
      if all_away_games.count != 0
        average_away_goals = total_goals.to_f / all_away_games.count.to_f
        scoring_breakdown[team] = average_away_goals.to_f.round(3)
      else 
        nil
      end 
    end 
    last_team_id = nil
    scoring_breakdown.each { |key, value| last_team_id = key if  value == scoring_breakdown.values.min}
    team_id_to_name(last_team_id)
  end

  def highest_scoring_home_team
    scoring_breakdown = {}
    teams = @teams.map { |team| team.team_id }
    teams.each do |team|
      all_home_games = @games.find_all { |game| game.home_team_id == team}
      total_goals = all_home_games.map { |home_game| home_game.home_goals.to_i}.sum
      if all_home_games.count != 0
        average_home_goals = total_goals.to_f / all_home_games.count.to_f
        scoring_breakdown[team] = average_home_goals.to_f.round(2)
      else 
        nil
      end 
    end 
    leading_team_id = nil
    scoring_breakdown.each { |key, value| leading_team_id = key if  value == scoring_breakdown.values.max }
    team_id_to_name(leading_team_id)
  end

  def lowest_scoring_home_team
    scoring_breakdown = {}
    teams = @teams.map { |team| team.team_id }
    teams.each do |team|
      all_home_games = @games.find_all { |game| game.home_team_id == team}
        total_goals = all_home_games.map { |home_game| home_game.home_goals.to_i}.sum
        if all_home_games.count != 0
          average_home_goals = total_goals.to_f / all_home_games.count.to_f
          scoring_breakdown[team] = average_home_goals.to_f.round(3)
        else 
          nil
        end 
    end 
    last_team_id = nil
    scoring_breakdown.each { |key, value| last_team_id = key if  value == scoring_breakdown.values.min}
    team_id_to_name(last_team_id)
  end
end