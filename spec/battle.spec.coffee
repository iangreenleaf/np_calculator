describe "Battle", ->
  describe "when empty", ->
    beforeEach ->
      @battle = new Battle
    it "assumes default values", ->
      expect(@battle.get "attacker_ships").toEqual null
      expect(@battle.get "attacker_ws").toEqual 1
      expect(@battle.get "defender_ships").toEqual null
      expect(@battle.get "defender_ws").toEqual 1
    it "returns results", ->
      expect(@battle.attacker_ships_remaining()).toEqual 0
      expect(@battle.defender_ships_remaining()).toEqual 0
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
  describe "ships to survive", ->
    it "calculates ships for attacker", ->
      @battle = new Battle
        attacker_ships: null
        attacker_ws: 3
        defender_ships: 10
        defender_ws: 3
      expect(@battle.attacker_ships_to_survive()).toEqual 17
    it "calculates ships for defender", ->
      @battle = new Battle
        attacker_ships: 10
        attacker_ws: 3
        defender_ships: null
        defender_ws: 3
      expect(@battle.defender_ships_to_survive()).toEqual 7
    it "calculates ship for defender's single strike", ->
      @battle = new Battle
        attacker_ships: 4
        attacker_ws: 3
        defender_ships: null
        defender_ws: 3
      expect(@battle.defender_ships_to_survive()).toEqual 1
    describe "null results", ->
      it "is null when values exists", ->
        @battle = new Battle
          attacker_ships: 3
          attacker_ws: 3
          defender_ships: 3
          defender_ws: 3
        expect(@battle.defender_ships_to_survive()).toEqual null
        expect(@battle.attacker_ships_to_survive()).toEqual null
      it "is null when values aren't defined", ->
        @battle = new Battle
        expect(@battle.defender_ships_to_survive()).toEqual null
        expect(@battle.attacker_ships_to_survive()).toEqual null
