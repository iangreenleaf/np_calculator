class window.BattleView extends Backbone.View

  el: "form"

  events: {
    "keyup input": "updateModel"
  }

  updateModel: ->
    params = _.reduce(
      $("form").serializeArray(),
      (params, obj) ->
        params[obj.name] = parseInt obj.value
        params
      ,
      {}
    )
    this.model.set params

class window.BattleResultsView extends Backbone.View
  initialize: ->
    @model.bind "change", @render, @

  render: ->
    $(@el).html(ich.battle_results(@model.toJSON()))
    this

$(document).ready ->
  window.battle = new Battle
  battle_form = new BattleView model: window.battle
  battle_results = new BattleResultsView model: window.battle
  $("#content").append(battle_results.render().el)

