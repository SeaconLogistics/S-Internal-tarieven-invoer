load File.expand_path('../tasks/build.rake', __FILE__)
load File.expand_path('../tasks/cucumber.rake', __FILE__)

require 'jasmine'
load 'jasmine/tasks/jasmine.rake'

task spec: ['build:all', 'jasmine:ci']

task default: [:cucumber, :spec]
