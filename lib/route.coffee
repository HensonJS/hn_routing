
# BaseRoute class definition
# The base route reduces repeated code by
# attaching the @container property passed in from
# the router. This property is used to display views in the app
class BaseRoute extends Backbone.Routing.Route

  breadcrumbs: []

  initialize: (options) ->

    # Attaches options
    @options = options

    # Attaches container
    @container = options.container

    # Event handlers
    @on 'before:enter', => @onBeforeEnter?(arguments)
    @on 'before:fetch', => @onBeforeFetch?(arguments)
    @on 'before:render', => @onBeforeRender?(arguments)
    @on 'fetch', => @onFetch?(arguments)
    @on 'render', => @onRender?(arguments)
    @on 'enter', => @onEnter?(arguments)

    # Hides sidebar component
    Backbone.Radio.channel('sidebar').trigger('hide')

  _setPageTitle: ->
    document.title = _.result @, 'title'

  _updateBreadcrumbs: ->
    breadcrumbs = _.result @, 'breadcrumbs'
    Backbone.Radio.channel('breadcrumb').trigger('set', breadcrumbs) if breadcrumbs

  onFetch: ->
    @_setPageTitle()
    @_updateBreadcrumbs()

# # # # #

module.exports = BaseRoute
