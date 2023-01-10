module Calculable
  def nested_hash_creator
    Hash.new {|h,k| h[k] = Hash.new(0) }
  end

  def team_id_to_name(id)
    @teams.find { |team| team.team_id == id }.team_name
  end

  def list_games_by_season(season_id)
    games_list = []
    @games.each do |row|
      games_list << row.game_id if row.season == season_id
    end
    games_list
  end
end