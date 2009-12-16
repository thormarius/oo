desc 'Generate a .gems file for Heroku'
task :dotgems => :environment do
  File.open('.gems', 'w') do |f|
    Rails.configuration.gems.each do |gem|
      gem_line = "#{gem.name} --version '#{gem.requirement}'"
      gem_line <<  " --source #{gem.source}" if gem.source
      f.puts gem_line
    end
  end
end