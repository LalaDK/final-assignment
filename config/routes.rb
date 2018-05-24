Rails.application.routes.draw do

  get "user_count",                   to: "main#user_count"
  get "users_mentioning_most_users",  to: "main#users_mentioning_most_users"
  get "most_mentioned_users",         to: "main#most_mentioned_users"
  get "most_active_users",            to: "main#most_active_users"
  get "top_ten_tweets",         to: "main#top_ten_tweets"

  root to: "main#landing_page"
end
