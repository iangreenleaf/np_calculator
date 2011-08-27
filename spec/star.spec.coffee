describe "Battle", ->
  describe "when empty", ->
    beforeEach ->
      @star = new Star
    it "gives null minimum projected ships", ->
      expect(@star.min_projected_ships()).toBeNull
    it "gives null maximum projected ships", ->
      expect(@star.max_projected_ships()).toBeNull
    it "gives null probability of maximum", ->
      expect(@star.extra_ship_probability()).toBeNull
  describe "projected ships", ->
    beforeEach ->
      @star = new Star
        industry: 4
        eta: 4
        ships: 10
    it "calculates minimum projected ships", ->
      expect(@star.min_projected_ships()).toEqual 11
    it "calculates maximum projected ships", ->
      expect(@star.max_projected_ships()).toEqual 12
    it "calculates probability of maximum", ->
      expect(@star.extra_ship_probability()).toEqual 33
