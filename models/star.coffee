class window.Star extends Backbone.RelationalModel
  defaults:
    ships: null
    industry: null
    eta: null
    ws: 1

  min_projected_ships: ->
    Math.floor @projected_ships()
  max_projected_ships: ->
    Math.ceil @projected_ships()
  extra_ship_probability: ->
    Math.round 100 * (@projected_ships() - Math.floor @projected_ships())
  projected_ships: ->
    @get("ships") + (@get("eta") * @get("industry") / 12)
