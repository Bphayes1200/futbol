require 'csv'

class StatTracker
  attr_reader :data_array,
              :games,
              :teams,
              :game_teams


  def self.from_csv(locations)
    @data_array = locations.values.map {|location| location }
    @stat_tracker = StatTracker.new(@data_array)
  end

  def initialize(data_array)
    @data_array = data_array
    @games = CSV.read @data_array[0], headers: true, header_converters: :symbol
    @teams = CSV.read @data_array[1], headers: true, header_converters: :symbol
    @game_teams = CSV.read @data_array[2], headers: true, header_converters: :symbol
  end

  def highest_total_score
    @games.map {|row| row[:home_goals].to_i + row[:away_goals].to_i}.max
  end

  def average_goals_per_game
    total_games = @games.map { |row| row[:game_id]}.count
    total_goals = @games.map { |row| row[:home_goals].to_i + row[:away_goals].to_i}.sum
    (total_goals.to_f / total_games).round(2)
  end


  def average_goals_by_season
    # average_goals_by_season = {}
    # goal_amounts = []
    # all_seasons = @games.map { |row| row[:season]}
    #   all_seasons.uniq.each do |season|
    #     @games.each do |row| 
    #       if row[:season] == season 
    #         goals = row[:home_goals].to_i + row[:away_goals].to_i
    #         goal_amounts << goals
    #         # require 'pry'; binding.pry
    #   end
    # end 
    # all_seasons.uniq.each do |season|
    #   average_goals_by_season[season] = goal_amounts.sum
    # # require 'pry'; binding.pry
    #  average_goals_by_season 
    #   end
    # end
  end 

   def count_of_games_by_season
    count_of_games_by_season = Hash.new(0)
         seasons = @games.map { |row| row[:season]}.tally
   end

  def percentage_home_wins
    tally = 0
    @game_teams.find_all do |row|
       tally += 1 if (row[:hoa] == "home" && row[:result] == "WIN") || (row[:hoa] == "away" && row[:result] == "LOSS")
    end
    (tally.to_f / @game_teams.count.to_f).round(2)
  end

  def percentage_visitor_wins
    tally = 0
    @game_teams.find_all do |row|
       tally += 1 if (row[:hoa] == "away" && row[:result] == "WIN") || (row[:hoa] == "home" && row[:result] == "LOSS")
    end
    (tally.to_f / @game_teams.count.to_f).round(2)
  end

  def percentage_ties
    tally = 0 
    @game_teams.find_all do |row|
       tally += 1 if (row[:hoa] == "away" && row[:result] == "TIE") || (row[:hoa] == "home" && row[:result] == "TIE")
    end
    (tally.to_f / @game_teams.count.to_f).round(2)
  end


#These methods each take a season id as an argument and return the values described
#Name of the Team with the best ratio of shots to goals for the season, returns a string
#for given season find
  #only games in this season
#  find game_teams only of those games
#
 #use goals.sum/shots.sum
  #all goals/all shots
 #and pluck the largest ratio
  def teams_by_accuracy(season)
    games_for_season = @games.find_all do |game|
      game[:season] == season
    end
    game_ids = games_for_season.map do |game|
      game[:game_id]
    end
    games_teams_for_season = @game_teams.find_all do |game_team|
     game_ids.include?(game_team[:game_id])
    end

    games_grouped_by_team = games_teams_for_season.group_by do |game_team|
      game_team[:team_id]
    end
  
    ratios_grouped_by_team = games_grouped_by_team.map do |team_id, game_teams|
      # require 'pry'; binding.pry
      goals = game_teams.sum {|game_team| game_team[:goals].to_i} 
      shots=  game_teams.sum {|game_team| game_team[:shots].to_i}
      ratio = goals/shots.to_f
      {team_id =>ratio}
    end
  end
  

  def most_accurate_team(season)
    team_id = teams_by_accuracy(season).max_by do |team, ratio|
      ratio
      
    end.keys.first
 
    team = @teams.find do |team|
    team_id == team[:team_id]
    end
    team[:teamname]
  end

  def least_accurate_team(season)
    team_id = teams_by_accuracy(season).min_by do |team, ratio|
      ratio
    end.keys.first
   
    team = @teams.find do |team|
    team_id == team[:team_id]
  end
    team[:teamname]
    end

  end



























