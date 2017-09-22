# for tracking devise install
devise = false

# Angular gems
gem 'angular-rails-templates'
gem 'angular_rails_csrf'

# misc gems
gem 'foundation-rails'
gem 'responders'

# testing
gem_group :development, :test do
  gem "rspec-rails"
  gem "capybara"
end

# whether or not you will need users
if yes?("Would you like to install Devise?")
  gem "devise"
  devise = true
  generate "devise:install"
  model_name = ask("What would you like the user model to be called? [user]")
  model_name = "user" if model_name.blank?
  generate "devise", model_name
end

run "bower init"

# change source path
def source_paths
  Array(super) +
    [File.join(File.expand_path(File.dirname(__FILE__)),'angularRails_root')]
end

# create angular stuffs
inside 'app' do
	inside 'assets' do 
		empty_directory 'javascripts'
		inside 'javascripts' do 
			empty_directory 'controllers'
			empty_directory 'services'
			empty_directory 'views'
			empty_directory 'directives'
			create_file 'application.js'
			insert_into_file "application.js", :after => "" do
				javascripts = [
					"angular",
					"angular-rails-templates",
					"angular-ui-router"
				]
				if devise
					javascripts.push("AngularDevise")
				end
				javascripts.map! {|script| "//= require " + script}
				javascripts.push("//= require_tree .")
				javascripts.join("\n")
			end
			template 'app.js'
		end
	end
	inside 'views' do 
		inside 'layouts' do
			insert_into_file 'application.html.erb', "\n\t<%= javascript_include_tag 'application' %>", :after => "<%= stylesheet_link_tag    'application', media: 'all' %>"			
		end
	end
end

# initialize git
git :init