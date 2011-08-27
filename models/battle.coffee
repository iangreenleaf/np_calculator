class window.Battle extends Backbone.RelationalModel
  defaults:
    attacker:
      ships: null
      ws: 1
    defender:
      ships: null
      ws: 1

  relations: [
    {
      type: Backbone.HasOne
      key: "defender"
      relatedModel: "Star"
    },
    {
      type: Backbone.HasOne
      key: "attacker"
      relatedModel: "Fleet"
    }
  ]

  attacker_ships_remaining: ->
    @ships_remaining_helper "attacker", "defender"
  defender_ships_remaining: ->
    @ships_remaining_helper "defender", "attacker"

  attacker_ships_to_survive: ->
    @ships_to_survive_helper "attacker", "defender"
  defender_ships_to_survive: ->
    @ships_to_survive_helper "defender", "attacker"

  defender_turns: ->
    turns = Math.min @turns_needed("attacker","defender"), @turns_needed("defender","attacker")
  attacker_turns: ->
    turns = @defender_turns()
    turns -= 1 if turns == @turns_needed("defender", "attacker") and turns > 0
    turns

  ships_to_survive_helper: (us, them) ->
    return null if @get(us).get("ships") > 0 or not @get(them).get("ships")?
    turns_needed = @turns_needed us, them
    turns_needed -= 1 if us is "defender"
    turns_needed * @get(them).weapons() + 1

  turns_needed: (us, them) ->
    Math.ceil @get(them).get("ships") / @get(us).weapons()

  ships_remaining_helper: (us, them) ->
    Math.max(
      0,
      @get(us).get("ships") - @["#{them}_turns"]() * @get(them).weapons()
    )

  toJSON: ->
    _.extend super, @prepare_hash()

  prepare_hash: ->
    props = [ 'attacker_ships_remaining', 'defender_ships_remaining', 'attacker_ships_to_survive', 'defender_ships_to_survive' ]
    result = {}
    result[p] = @[p]() for p in props
    result
