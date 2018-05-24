class Tweet
  include Mongoid::Document
  store_in collection: "tweets"

  field :id, type: Integer
  field :polarity, type: Integer
  field :date, type: String
  field :query, type: String
  field :user, type: String
  field :text, type: String

  index({:"user" => 1}, {name: "user_index"})
  index({:"polariry" => 1}, {name: "polariry_index"})

  def self.user_count
    distinct('user').length
  end

  def self.users_mentioning_most_users
    collection.aggregate([
        {"$match": {"text": /@\w+/}},
        {"$group": {_id: "$user","text": {"$push": "$text"}}},
        {"$project": {_id: "$_id", "matches": {"$size": "$text"}}},
        {"$sort": {"matches": -1}},
        {"$limit": 10}
      ], :allow_disk_use => true)
  end

  def self.most_mentioned_users
    collection.aggregate([
      {"$match":{"text":/@\w+/}},
      {"$project": {"text": {"$split": ["$text", " "]}}},
      {"$unwind": "$text"},
      {"$match": {"text": /@\w+/}},
      {"$group": {_id: "$text", "occurrences": {"$sum": 1}}},
      {"$sort": {"occurrences": -1}},
      {"$limit": 10}
    ], :allow_disk_use => true)
  end

  def self.most_active_users_by_tweet_count
    collection.aggregate([
      {"$group": {"_id": "$user", "tweets": {"$sum": 1}}},
      {"$sort": {"tweets": -1}},
      {"$limit": 10}
    ], :allow_disk_use => true).to_a
  end

  def self.most_active_users_by_longest_tweet
    collection.aggregate([
      {"$project": {"_id": "$user", "tweet": "$text", "length": { "$strLenCP": "$text" }}},
      {"$sort": {"length": -1}},
      {"$limit": 10}
    ], :allow_disk_use => true).to_a
  end

  def self.most_negative_tweets
    collection.aggregate([
      {"$project": {"_id": "$user", "polarity": "$polarity", "tweet": "$text", "date": "$date"}},
      {"$sort": {"polarity": 1}},
      {"$limit": 10}
    ], :allow_disk_use => true).to_a
  end

  def self.most_positive_tweets
    collection.aggregate([
      {"$project": {"_id": "$user", "polarity": "$polarity", "tweet": "$text", "date": "$date"}},
      {"$sort": {"polarity": -1}},
      {"$limit": 10}
    ], :allow_disk_use => true).to_a
  end
end
