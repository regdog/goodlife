class CheckinObserver < ActiveRecord::Observer
  def before_create(checkin)
    user = checkin.user
    feat = checkin.feat
    # log checkin for user habits
    user.scheduled_habits.each do |habit|
      checkin.scheduled_habits << habit if feat.id == habit.feat_id
    end
    # log checkin for user challenges
    user.uncompleted_scheduled_challenges.each do |challenge|
      if challenge.unfinished_feats.include?(feat)
        if challenge.unfinished_feats.size == 1
          checkin.checkins_scheduled_tasks.build(:checkin_id => checkin.id, :scheduled_id=>challenge.id, :scheduled_type=>challenge.class.to_s, :completed=>true)
          challenge.completed_at = Time.now
          challenge.save
        else
          checkin.scheduled_challenges << challenge
        end
      end
    end
  end
end
