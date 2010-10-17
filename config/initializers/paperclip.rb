if RAILS_ENV == "production"
  Paperclip.options[:command_path] = '/usr/bin/identify/'
else
  Paperclip.options[:command_path] = '/opt/local/bin/'
end