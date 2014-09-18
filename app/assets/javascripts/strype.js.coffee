window.Strype = ()->

Strype.Card = (options) ->
  throw "Cannot initialize without arguments" unless options
  @card_number = options.card_number
  throw "No Card Number" unless @card_number

Strype.Card.prototype = {

  valid_number: () ->
    LuhnCheck.check @card_number
}

Strype.Charge = (options) ->
  @card = options.card
  @amount = options.amount

Strype.Charge.prototype = {

  create: (options) ->
    $.ajax(
      url: "/charges",
      data: JSON.stringify(card: {number: @card.card_number, amount: @amount}),
      type: 'POST',
      contentType: 'application/json',
      success: () ->
        options.success?.call()
      error: () ->
        options.error?.call()
    )

}
