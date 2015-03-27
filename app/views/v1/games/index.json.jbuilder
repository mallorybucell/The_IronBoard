json.array! @games do |game|
  # json(game, :name, :game_data, :game_summary, :date_played)
  json.name         game.name
  json.game_data    game.game_data
  json.game_summary game.game_summary
  json.date_played  game.date_played
end