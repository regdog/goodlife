$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'spec'
require 'spec/autorun'
require 'active_record'
require 'party_boy'
require "#{File.dirname(__FILE__)}/../generators/party_boy/templates/model"
require 'models/follower_class'
require 'models/friend_class'

ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + '/debug.log')
ActiveRecord::Base.configurations = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.establish_connection(ENV['DB'] || 'mysql')
 
load(File.dirname(__FILE__) + '/schema.rb')

Spec::Runner.configure do |config|
  
end
