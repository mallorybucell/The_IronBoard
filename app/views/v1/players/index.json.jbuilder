json.array! @users do |user|
  # json(user, :username, :sex, :avatar_url)
  json.username    user.username
  json.sex         user.sex
  json.avatar_url  user.avatar_url
  # json.wins
  # json.losses
end