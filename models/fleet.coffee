class window.Fleet extends Backbone.RelationalModel
  defaults:
    ships: null
    ws: 1

  weapons: ->
    @get("ws")
