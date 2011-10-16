class Content < ActiveRecord::Base
  belongs_to :tag
  belongs_to :user
  permalink :title

  validates_presence_of :title, :permalink, :content


  #TYPES = ['Blog', 'Page', 'Snippet']
end
