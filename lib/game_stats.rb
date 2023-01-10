class GameStats < Stats

  def highest_total_score
    @games.map {|row| row.home_goals.to_i + row.away_goals.to_i}.max
  end

  def lowest_total_score
    @games.map {|row| row[:home_goals].to_i + row[:away_goals].to_i}.min
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

  def count_of_games_by_season
    count_of_games_by_season = Hash.new(0)
         seasons = @games.map { |row| row[:season]}.tally
  end

  def average_goals_per_game
    total_games = @games.map { |row| row[:game_id]}.count
    total_goals = @games.map { |row| row[:home_goals].to_i + row[:away_goals].to_i}.sum
    (total_goals.to_f / total_games).round(2)
  end

  def average_goals_by_season
    average_goals_by_season = {}
    all_seasons = @games.map { |row| row[:season]}
    all_seasons.uniq.each do |season|
      all_games = @games.find_all { |row| season == row[:season]}
        total_score = all_games.map { |row| row[:home_goals].to_i + row[:away_goals].to_i }
          average_goals_by_season[season] = ((total_score.sum.to_f / all_games.count.to_f).round(2))

    end 
    average_goals_by_season
  end   
end