window.Strype = ()->

Strype.Card = (options) ->
  throw "Cannot initialize without arguments" unless options
  @card_number = options.card_number
  throw "No Card Number" unless @card_number

Strype.Card.prototype = {

  valid_number: () ->
    LuhnCheck.check @card_number

}
