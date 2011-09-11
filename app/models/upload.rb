class Upload < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
  delegate :url, :to => :upload
end
