json.array! @users do |user|
  # json(user, :username, :sex, :avatar_url)
  json.user_id     user.id
  json.username    user.username
  json.sex         user.sex
  json.avatar_url  user.avatar_url
  json.wins        rand(1..5)
  json.losses      rand(1..5)
end