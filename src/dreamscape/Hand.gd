extends Hand

signal hand_refilled
signal hand_emptied

var is_hand_refilled := false
var refill_amount := 5
var discard_at_turn_end := true

func _ready() -> void:
	pass

func empty_hand() -> void:
	is_hand_refilled = false
	for card in get_all_cards():
		if Terms.GENERIC_TAGS.frozen.name in card.get_property("Tags"):
			continue
		if card.state == DreamCard.ExtendedCardState.REMOVE_FROM_GAME:
			continue
		yield(get_tree().create_timer(0.05), "timeout")
		card.move_to(cfc.NMAP.discard)
	emit_signal("hand_emptied")

func refill_hand(amount = refill_amount) -> void:
	for _iter in range(amount):
		var retcode = draw_card(cfc.NMAP.deck)
		if retcode == null:
			break
		elif retcode is GDScriptFunctionState:
			retcode = yield(retcode, "completed")
		else:
			yield(get_tree().create_timer(0.05), "timeout")
	is_hand_refilled = true
	emit_signal("hand_refilled")


func are_cards_still_animating() -> bool:
	for c in get_all_cards():
		if c.state in [Card.CardState.MOVING_TO_CONTAINER]:
			return(true)
	return(false)


# Takes the top card from the specified [CardContainer]
# and adds it to this node
# Returns a card object drawn
func draw_card(pile : Pile = cfc.NMAP.deck) -> Card:
	var card: Card = pile.get_top_card()
	# A basic function to pull a card from out deck into our hand.
	if not card:
		cfc.NMAP.discard.reshuffle_in_deck()
		yield(pile, "shuffle_completed")
		card = pile.get_top_card()
	if card:
		card.move_to(self)
	return card

func _on_player_turn_started(_turn: Turn) -> void:
	pass

func _on_player_turn_ended(_turn: Turn) -> void:
	if discard_at_turn_end:
		var retcode  = empty_hand()
		if retcode is GDScriptFunctionState:
			retcode = yield(retcode, "completed")
	refill_hand()
