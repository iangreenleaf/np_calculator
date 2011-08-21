describe "Battle", ->
  beforeEach ->
    @battle = new Battle
  describe "when empty", ->
    it "has null result", ->
      expect(1).toEqual 0
  describe "foo", ->
    it "is 5", ->
      expect(@battle.foo()).toEqual 5
