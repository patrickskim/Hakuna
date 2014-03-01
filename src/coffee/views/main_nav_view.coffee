class App.Views.MainNavView extends Backbone.View
  el: "#main-nav"

  THRESHOLD:
    delta: 15
    header: 700

  initialize: (options ={}) ->
    @application = options.application
    @previous_scroll = 0

    @listenTo @application, "scroll",  @scroll_event
    @render()

  render: ->
    this

  scroll_event: (scroll_amt) =>
    @_toggle_visibility(scroll_amt)
    @_toggle_fixed(scroll_amt)

  _toggle_fixed: (scroll_amt) ->
    @$el.toggleClass "fixed", scroll_amt > @THRESHOLD["header"]

  _toggle_visibility: (scroll_amt) ->
    return @$el.removeClass "hidden" if scroll_amt < @THRESHOLD["header"] - 50
    return if @_scroll_delta(scroll_amt) < @THRESHOLD["delta"]
    @$el.toggleClass("hidden", scroll_amt > @previous_scroll)
    @previous_scroll = scroll_amt

  _scroll_delta: (scroll_amt) ->
    Math.abs(@previous_scroll - scroll_amt)
    