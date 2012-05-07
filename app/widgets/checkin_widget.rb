class CheckinWidget < Apotomo::Widget
  responds_to_event :submit

  def display
    @feat = Feat.first
    render
  end

  def submit(evt)
    #render :text => "alert('#{evt.data.inspect}')"
    evt[:checkin][:user_id] = 1
    @checkin = Checkin.create(evt[:checkin])
    trigger :new_checkin
    replace "#d_checkin_post", :view => :post_checkin
  end
end
