class MainController < ApplicationController

  def landing_page
    respond_to do |format|
      format.html do
      end
    end
  end

  def user_count
    respond_to do |format|
      format.html do
        @user_count = Tweet.user_count
      end
    end
  end

  def most_active_users
    respond_to do |format|
      format.html do
        @most_active_users_by_tweet_count = Tweet.most_active_users_by_tweet_count
        @most_active_users_by_longest_tweet = Tweet.most_active_users_by_longest_tweet
      end
    end
  end

  def users_mentioning_most_users
    respond_to do |format|
      format.html do
        @users = Tweet.users_mentioning_most_users
      end
    end
  end

  def top_ten_tweets
    respond_to do |format|
      format.html do
        @most_positive_tweets = Tweet.most_positive_tweets
        @most_negative_tweets = Tweet.most_negative_tweets
      end
    end
  end

  def most_mentioned_users
    respond_to do |format|
      format.html do
        @most_mentioned_users = Tweet.most_mentioned_users
      end
    end
  end
end
