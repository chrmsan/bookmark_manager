class Tagging
  include DataMapper::Resource

  belongs_to :tags, :key => true
  belongs_to :links, :key => true

end
