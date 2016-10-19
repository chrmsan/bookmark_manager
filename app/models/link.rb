require 'data_mapper'
require 'dm-postgres-adapter'

class Link
  include DataMapper::Resource

  property :id,      Serial
  property :title,   String
  property :url,     String
end

DataMapper.setup(:default, ('postgres://lnhkbfobpqejri:1TBMaDSa4bTqId9XSgHDjBw8_0@ec2-54-243-249-56.compute-1.amazonaws.com:5432/d13fotaai53k12' || "postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}"))
DataMapper.finalize
DataMapper.auto_upgrade!
