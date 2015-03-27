json.array! @games do |game|
  json.name         game.name
  json.game_data    game.game_data
  json.game_summary game.game_summary
  json.date_played  game.date_played
end