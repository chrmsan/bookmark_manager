class User
  include DataMapper::Resource

  has n, :links, through: Resource

  property :id,   Serial
  property :first_name, String
  property :last_name, String
  property :email, String
  property :password, String
  
end
