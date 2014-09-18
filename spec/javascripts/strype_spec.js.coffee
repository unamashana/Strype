describe "Strype", ->

  it "should be defined", ->
    expect(Strype).toBeDefined()

  describe "Strype.Card", ->

    it "should be defined", ->
      expect(Strype.Card).toBeDefined()


  describe "Initialization", ->
    it "should throw an error if initialized without a card", ->
      expect(() -> new Strype.Card).toThrow("Cannot initialize without arguments")

    it "should throw an error if card number is not provided", ->
      expect(() -> new Strype.Card {}).toThrow("No Card Number")

    it "should not throw an error if card number is provided", ->
      expect(() -> new Strype.Card {card_number: 'xxx'}).not.toThrow()

