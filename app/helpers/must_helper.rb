module MustHelper

  def do_i_agree(must_id)
    agree = Agree.find(:first, :conditions => {:user_id => current_user.id, :must_id => must_id })
    unless agree.nil?
      if agree.calification == 0
        "I Disagree"
      else
        "I Agree"
      end
    else
      ''
    end
  end

end