# init acts_as_shareable
require 'acts_as_shareable'
ActiveRecord::Base.send(:include, CC::Acts::Shareable)