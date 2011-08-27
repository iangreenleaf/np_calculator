describe "Battle", ->
  describe "when empty", ->
    beforeEach ->
      @battle = new Battle
    it "assumes default values", ->
      expect(@battle.get("attacker").get("ships")).toEqual null
      expect(@battle.get("attacker").get("ws")).toEqual 1
      expect(@battle.get("defender").get("ships")).toEqual null
      expect(@battle.get("defender").get("ws")).toEqual 1
    it "returns results", ->
      expect(@battle.attacker_ships_remaining()).toEqual 0
      expect(@battle.defender_ships_remaining()).toEqual 0
  describe "results", ->
    describe "attacker wins", ->
      beforeEach ->
        @battle = new Battle
          attacker:
            ships: 3
            ws: 1
          defender:
            ships: 1
            ws: 1
      it "reports ships remaining", ->
        expect(@battle.attacker_ships_remaining()).toEqual 1
        expect(@battle.defender_ships_remaining()).toEqual 0
    describe "attacker wins empty star", ->
      beforeEach ->
        @battle = new Battle
          attacker:
            ships: 3
            ws: 3
          defender:
            ships: 0
            ws: 3
      it "reports ships remaining", ->
        expect(@battle.attacker_ships_remaining()).toEqual 3
        expect(@battle.defender_ships_remaining()).toEqual 0
    describe "defender wins from bonus", ->
      beforeEach ->
        @battle = new Battle
          attacker:
            ships: 10
            ws: 3
          defender:
            ships: 7
            ws: 3
      it "reports ships remaining", ->
        expect(@battle.attacker_ships_remaining()).toEqual 0
        expect(@battle.defender_ships_remaining()).toEqual 1
    describe "defender wins by striking first", ->
      beforeEach ->
        @battle = new Battle
          attacker:
            ships: 5
            ws: 3
          defender:
            ships: 1
            ws: 4
      it "reports ships remaining", ->
        expect(@battle.attacker_ships_remaining()).toEqual 0
        expect(@battle.defender_ships_remaining()).toEqual 1
  describe "ships to survive", ->
    it "calculates ships for attacker", ->
      @battle = new Battle
        attacker:
          ships: null
          ws: 3
        defender:
          ships: 10
          ws: 3
      expect(@battle.attacker_ships_to_survive()).toEqual 17
    it "calculates ships for defender", ->
      @battle = new Battle
        attacker:
          ships: 10
          ws: 3
        defender:
          ships: null
          ws: 3
      expect(@battle.defender_ships_to_survive()).toEqual 7
    it "calculates ship for defender's single strike", ->
      @battle = new Battle
        attacker:
          ships: 4
          ws: 3
        defender:
          ships: null
          ws: 3
      expect(@battle.defender_ships_to_survive()).toEqual 1
    describe "null results", ->
      it "is null when values exists", ->
        @battle = new Battle
          attacker:
            ships: 3
            ws: 3
          defender:
            ships: 3
            ws: 3
        expect(@battle.defender_ships_to_survive()).toEqual null
        expect(@battle.attacker_ships_to_survive()).toEqual null
      it "is null when values aren't defined", ->
        @battle = new Battle
        expect(@battle.defender_ships_to_survive()).toEqual null
        expect(@battle.attacker_ships_to_survive()).toEqual null
