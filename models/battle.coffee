class window.Battle extends Backbone.Model
  defaults:
    attacker_ships: null
    attacker_ws: 1
    defender_ships: null
    defender_ws: 1

  attacker_ships_remaining: ->
    @ships_remaining_helper "attacker", "defender"
  defender_ships_remaining: ->
    @ships_remaining_helper "defender", "attacker"

  attacker_ships_to_survive: ->
    @ships_to_survive_helper "attacker", "defender"
  defender_ships_to_survive: ->
    @ships_to_survive_helper "defender", "attacker"

  defender_turns: ->
    turns = Math.min @attacker_turns_needed(), @defender_turns_needed()
  attacker_turns: ->
    turns = @defender_turns()
    turns -= 1 if turns == @defender_turns_needed() and turns > 0
    turns

  defender_turns_needed: ->
    @turns_needed_helper "defender", "attacker"
  attacker_turns_needed: ->
    @turns_needed_helper "attacker", "defender"

  attacker_weapons: ->
    @get "attacker_ws"
  defender_weapons: ->
    @get("defender_ws") + 1

  ships_to_survive_helper: (us, them) ->
    return null if @get("#{us}_ships") > 0 or not @get("#{them}_ships")?
    turns_needed = @["#{us}_turns_needed"]()
    turns_needed -= 1 if us is "defender"
    turns_needed * @["#{them}_weapons"]() + 1

  turns_needed_helper: (us, them) ->
    Math.ceil @get("#{them}_ships") / @["#{us}_weapons"]()

  ships_remaining_helper: (us, them) ->
    Math.max(
      0,
      @get("#{us}_ships") - @["#{them}_turns"]() * @["#{them}_weapons"]()
    )
