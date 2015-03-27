json.array! @users do |user|
  json.user_id     user.id
  json.username    user.username
  json.sex         user.sex
  json.avatar_url  user.avatar_url
  json.wins        user.total_wins
  json.losses      user.total_losses
end