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

  describe "Card Number Validation", ->

    it "should return false if the card number is invalid", ->
      @card = new Strype.Card card_number: 'xxx'
      expect(@card.valid_number()).toBe false
    
    it "should return true if the card number is valid", ->
      @card = new Strype.Card card_number: '4242424242424242'
      expect(@card.valid_number()).toBe true
    
    it "should return true if the card number is valid", ->
      @card = new Strype.Card card_number: '4292810674576773'
      expect(@card.valid_number()).toBe true


    describe "Implementation", ->

      it "should return true if LuhnCheck returns true", ->
        mock = sinon.mock(LuhnCheck)
        mock.expects("check").withArgs("xxx").returns(true)

        @card = new Strype.Card card_number: 'xxx'
        expect(@card.valid_number()).toBe true

        mock.verify()
        mock.restore()

      it "should return false if LuhnCheck returns false", ->
        mock = sinon.mock(LuhnCheck)
        mock.expects("check").withArgs("xxx").returns(false)

        @card = new Strype.Card card_number: 'xxx'
        expect(@card.valid_number()).toBe false

        mock.verify()
        mock.restore()

