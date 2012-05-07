class ShareObserver < ActiveRecord::Observer
  def before_save(share)
    unless share.new_record?
      shared_to_user = share.shared_to
      shareable = share.shareable

      case shareable.class.to_s
        when "Feat"
          unless shared_to_user.todo_feats.include?(shareable)
            share.restricted = 0
          end
        when "Challenge"
          unless shared_to_user.todo_challenges.include?(shareable)
            share.restricted = 0
          end
      end
    end
  end
end
