class window.Battle extends Backbone.Model
  defaults:
    attacker_ships: 1
    attacker_ws: 1
    defender_ships: 1
    defender_ws: 1

  attacker_ships_remaining: ->
    @ships_remaining_helper "attacker", "defender"
  defender_ships_remaining: ->
    @ships_remaining_helper "defender", "attacker"
  defender_turns: ->
    turns = Math.min @attacker_turns_needed(), @defender_turns_needed()
  attacker_turns: ->
    turns = @defender_turns()
    turns -= 1 if turns == @defender_turns_needed()
    turns
  defender_turns_needed: ->
    @turns_needed_helper "defender", "attacker"
  attacker_turns_needed: ->
    @turns_needed_helper "attacker", "defender"
  attacker_weapons: ->
    @get "attacker_ws"
  defender_weapons: ->
    @get("defender_ws") + 1
  turns_needed_helper: (us, them) ->
    Math.ceil @get("#{them}_ships") / @["#{us}_weapons"]()
  ships_remaining_helper: (us, them) ->
    Math.max(
      0,
      @get("#{us}_ships") - @["#{them}_turns"]() * @["#{them}_weapons"]()
    )
