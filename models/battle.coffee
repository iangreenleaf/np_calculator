class window.Battle extends Backbone.Model
  defaults:
    attacker_ships: 0
    attacker_weapons: 0
    defender_ships: 0
    defender_weapons: 0

  attacker_ships_remaining: ->
    Math.max(
      0,
      @get("attacker_ships") - @defender_turns() * (@get("defender_weapons") + 1)
    )
  defender_ships_remaining: ->
    Math.max(
      0,
      @get("defender_ships") - @attacker_turns() * @get("attacker_weapons")
    )
  defender_turns: ->
    turns = Math.min @attacker_turns_needed(), @defender_turns_needed()
  attacker_turns: ->
    turns = @defender_turns()
    turns -= 1 if turns == @defender_turns_needed()
    turns
  defender_turns_needed: ->
    Math.ceil @get("attacker_ships") / (@get("defender_weapons") + 1)
  attacker_turns_needed: ->
    Math.ceil @get("defender_ships") / @get("attacker_weapons")
