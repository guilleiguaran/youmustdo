# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def submit_or_cancel(form, name='Cancel')
    form.submit + " or " + link_to(name, 'javascript:history.go(-1);', :class => 'cancel')
  end
  
end
