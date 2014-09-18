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


  describe "Charge", ->

    beforeEach ->
      @card = new Strype.Card card_number: 'xxxx'
      @charge = new Strype.Charge card: @card, amount: 10
      @success_callback = jasmine.createSpy('success_callback')
      @error_callback = jasmine.createSpy('error_callback')
      @server = sinon.fakeServer.create()

    afterEach ->
      @server.restore()

    it "should call the success handler when charge succeeds", ->
      @server.respondWith("POST", "/charges", [
        201, {"Content-Type":"application/json"}, '[{ "id": 12, "comment": "Hey there" }]'
      ])
      @charge.create(success: @success_callback)
      @server.respond()
      expect(@success_callback).toHaveBeenCalled()
      expect(@error_callback).not.toHaveBeenCalled()
      
    it "should call the failure handler when charge fails", ->
      @server.respondWith("POST", "/charges", [
        402, {"Content-Type":"application/json"}, '[{ "error": "cannot process charge"}]'
      ])
      @charge.create(success: @success_callback, error: @error_callback)
      @server.respond()
      expect(@success_callback).not.toHaveBeenCalled()
      expect(@error_callback).toHaveBeenCalled()
      
      
      
      



      
      



