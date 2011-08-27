class Tagging < ActiveRecord::Base
  belongs_to :taggable, :polymorphic => true

  belongs_to :feat, :foreign_key => "taggable_id"
  belongs_to :feat_category, :foreign_key => "tag_id"

  belongs_to :reward, :foreign_key => "taggable_id"
  belongs_to :reward_category, :foreign_key => "tag_id"
end
