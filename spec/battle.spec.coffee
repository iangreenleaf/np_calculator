describe "Battle", ->
  describe "when empty", ->
    beforeEach ->
      @battle = new Battle
    it "assumes default values", ->
      expect(@battle.get "attacker_ships").toEqual 1
      expect(@battle.get "attacker_ws").toEqual 1
      expect(@battle.get "defender_ships").toEqual 1
      expect(@battle.get "defender_ws").toEqual 1
    it "returns results", ->
      expect(@battle.attacker_ships_remaining()).toEqual 0
      expect(@battle.defender_ships_remaining()).toEqual 1
  describe "results", ->
    describe "attacker wins", ->
      beforeEach ->
        @battle = new Battle
          attacker_ships: 3
          attacker_ws: 1
          defender_ships: 1
          defender_ws: 1
      it "reports ships remaining", ->
        expect(@battle.attacker_ships_remaining()).toEqual 1
        expect(@battle.defender_ships_remaining()).toEqual 0
    describe "attacker wins empty star", ->
      beforeEach ->
        @battle = new Battle
          attacker_ships: 3
          attacker_ws: 3
          defender_ships: 0
          defender_ws: 3
      it "reports ships remaining", ->
        expect(@battle.attacker_ships_remaining()).toEqual 3
        expect(@battle.defender_ships_remaining()).toEqual 0
    describe "defender wins from bonus", ->
      beforeEach ->
        @battle = new Battle
          attacker_ships: 10
          attacker_ws: 3
          defender_ships: 7
          defender_ws: 3
      it "reports ships remaining", ->
        expect(@battle.attacker_ships_remaining()).toEqual 0
        expect(@battle.defender_ships_remaining()).toEqual 1
    describe "defender wins by striking first", ->
      beforeEach ->
        @battle = new Battle
          attacker_ships: 5
          attacker_ws: 3
          defender_ships: 1
          defender_ws: 4
      it "reports ships remaining", ->
        expect(@battle.attacker_ships_remaining()).toEqual 0
        expect(@battle.defender_ships_remaining()).toEqual 1
