# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'

    when /^the settings page$/
        '/settings'

    when /^the registration page$/
    	'/register'

    when /^the send an e-card page$/
    	'/send/ecard'

    when /^the send an e-card page$/
    	'/send/postcard'

    when /^the reminders page$/
    	'/send'

    when /^the admin page$/
    	'/admin'
    
    when /^the e-card acknowledgement page$/
    	'/send/success'

    when /^the login page$/
    	'/login'

    when /^the welcome page$/
    	welcome_path

    when /^the recover password page$/
			forgot_path	

		when /^the donation page$/
			# TODO
			'/'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
