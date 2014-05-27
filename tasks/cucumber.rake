begin
  require 'cucumber/rake/task'

  namespace :cucumber do
    Cucumber::Rake::Task.new({:ok => 'build'}, 'Run features that should pass') do |t|
      t.fork = false # You may get faster startup if you set this to false
      t.profile = 'default'
    end

    Cucumber::Rake::Task.new({:wip => 'build'}, 'Run features that are being worked on') do |t|
      t.fork = false # You may get faster startup if you set this to false
      t.profile = 'wip'
    end


    desc 'Run all features'
    task :all => [:ok, :wip]

  end

  desc 'Alias for cucumber:ok'
  task :cucumber => 'cucumber:ok'
end
