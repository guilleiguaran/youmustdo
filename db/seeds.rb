
category = Category.find_by_name("Read")
if category.nil?
Category.create(:name => "Read", 
:description => 'An awesome article or a great Book, maybe a cool blog post!, here you can tell the world they must read what you want')
end
category = Category.find_by_name("See")
if category.nil?
Category.create(:name => "See", 
:description => 'I saw that great thing I wanted everybody to see it. This is happening to you, right? Tell them, they Must see it ')
end
category = Category.find_by_name("Watch")
if category.nil?
Category.create(:name => "Watch", 
:description => 'Follow with the eyes or the mind, look attentively. Yes!, they must Watch it too!')
end
category = Category.find_by_name("Listen")
if category.nil?
Category.create(:name => "Listen", 
:description => 'Hey Jude was a great song back in the 60s, Everyone Must heard that. They also Must Listen your track')
end
category = Category.find_by_name("Have")
if category.nil?
Category.create(:name => "Have", 
:description => 'It is so awesome when you have something and make you so exited, so we they can feel just like you, share!, tell them waht they Must haveYe')
end
category = Category.find_by_name("Do")
if category.nil?
Category.create(:name => "Do", 
:description => 'You already did that! cool, now is their turn, tell them what they Must do to complete they existence')
end
category = Category.find_by_name("Visit")
if category.nil?
Category.create(:name => "Vist", 
:description => 'You already go ther? you want be in that special place?, tell everyone about this!')
end
category = Category.find_by_name("Play")
unless category.nil?
category.destroy
end
