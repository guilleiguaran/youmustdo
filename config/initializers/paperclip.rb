if Rails.env == "production"
  Paperclip.options[:command_path] = '/usr/bin/'
else
  Paperclip.options[:command_path] = '/opt/local/bin/'
end