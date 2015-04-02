Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  waitOn: () ->
    Meteor.subscribe 'projects'

Router.route '/',
  name: 'projectList'

Router.route '/:username/:project',
  name: 'projectPage'
  data: () ->
    Projects.findOne
      username: @params.username
      slug: @params.project