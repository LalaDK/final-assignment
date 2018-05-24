require 'test_helper'

class TweetTest < ActiveSupport::TestCase

  test "at 'Tweet.user_count' returnerer 659775" do
    actual = Tweet.user_count
    expected = 659775
    assert_equal actual, expected
  end

  test "at 'Tweet.users_mentioning_most_users' returnerer korrekt" do
    data = Tweet.users_mentioning_most_users.to_a
    assert_equal 10, data.length
    assert_equal 'lost_dog', data.first['_id']
    assert_equal 689, data.first['matches']
    assert_equal 'keza34', data.last['_id']
    assert_equal 212, data.last['matches']
  end

  test "at 'Tweet.most_mentioned_users' returnerer korrekt" do
    data = Tweet.most_mentioned_users.to_a
    assert_equal 10, data.length
    assert_equal '@mileycyrus', data.first['_id']
    assert_equal data.first['occurrences'], 4744
    assert_equal data.last['_id'], '@jonasbrothers'
    assert_equal data.last['occurrences'], 1024
  end

  test "at 'Tweet.most_active_users_by_tweet_count' returnerer korrekt" do
    data = Tweet.most_active_users_by_tweet_count.to_a
    assert_equal 10, data.length
    assert_equal 'lost_dog', data.first['_id']
    assert_equal 690, data.first['tweets']
    assert_equal 'tsarnick', data.last['_id']
    assert_equal 248, data.last['tweets']
  end

  test "at 'Tweet.most_active_users_by_longest_tweet' returnerer korrekt" do
    data = Tweet.most_active_users_by_longest_tweet.to_a
    assert_equal 10, data.length
    assert_equal 'Dutchrudder', data.first['_id']
    assert_equal 359, data.first['length']
    assert_equal 'spinesurgeon', data.last['_id']
    assert_equal 186, data.last['length']
  end

  test "at 'Tweet.most_negative_tweets' returnerer korrekt" do
    data = Tweet.most_negative_tweets.to_a
    assert_equal 10, data.length
    assert_equal 'Meghan_xoxo', data.first['_id']
    assert_equal 0, data.first['polarity']
    assert_equal 'typezero3', data.last['_id']
    assert_equal 0, data.last['polarity']
  end

  test "at 'Tweet.most_positive_tweets' returnerer korrekt" do
    data = Tweet.most_positive_tweets.to_a
    assert_equal 10, data.length
    assert_equal '_EmilyYoung', data.first['_id']
    assert_equal 4, data.first['polarity']
    assert_equal 'ersle', data.last['_id']
    assert_equal 4, data.last['polarity']
  end
end
