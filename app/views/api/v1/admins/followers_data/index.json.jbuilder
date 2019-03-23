json.users do
  json.array! @users, partial: "instagram_user", as: :user
end

json.chartData do
  json.array! @data, partial: "followers_datum", as: :datum
end
