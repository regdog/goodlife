class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :taggable, :polymorphic => true
  belongs_to :feat, :foreign_key => :taggable_id
  belongs_to :reward, :foreign_key => :taggable_id
end
