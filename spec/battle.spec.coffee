describe "Battle", ->
  beforeEach ->
    @battle = new Battle
  describe "when empty", ->
    it "has null result", ->
      expect(1).toEqual 0
  describe "results", ->
    describe "attacker wins", ->
      beforeEach ->
        @battle = new Battle
          attacker_ships: 3
          attacker_weapons: 1
          defender_ships: 1
          defender_weapons: 1
      it "reports ships remaining", ->
        expect(@battle.attacker_ships_remaining()).toEqual 1
        expect(@battle.defender_ships_remaining()).toEqual 0
    describe "attacker wins empty star", ->
      beforeEach ->
        @battle = new Battle
          attacker_ships: 3
          attacker_weapons: 3
          defender_ships: 0
          defender_weapons: 3
      it "reports ships remaining", ->
        expect(@battle.attacker_ships_remaining()).toEqual 3
        expect(@battle.defender_ships_remaining()).toEqual 0
    describe "defender wins from bonus", ->
      beforeEach ->
        @battle = new Battle
          attacker_ships: 10
          attacker_weapons: 3
          defender_ships: 7
          defender_weapons: 3
      it "reports ships remaining", ->
        expect(@battle.attacker_ships_remaining()).toEqual 0
        expect(@battle.defender_ships_remaining()).toEqual 1
    describe "defender wins by striking first", ->
      beforeEach ->
        @battle = new Battle
          attacker_ships: 5
          attacker_weapons: 3
          defender_ships: 1
          defender_weapons: 4
      it "reports ships remaining", ->
        expect(@battle.attacker_ships_remaining()).toEqual 0
        expect(@battle.defender_ships_remaining()).toEqual 1
