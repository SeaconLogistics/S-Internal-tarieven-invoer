#= require_self
#= require router
#= require_tree ./routes
#= require_tree ./controllers
#= require_tree ./routes
#= require_tree ./templates
#= require_tree ./views

window.STI = Em.Application.create
  rootElement: '#wrap'
  LOG_TRANSITIONS: true
  LOG_TRANSITIONS_INTERNAL: true
