# This class provides a deck of cards where the player can perform operations
# such as progressing or removing cards
class_name SelectionDeck
extends PopupPanel

# Emited after a succesful operation. The calling object should hook into it
# to know when to close this popup.
signal operation_performed(operation_type, card_name)

const CARD_CHOICE_SCENE = preload("res://src/dreamscape/ChoiceCardObject.tscn")

# Used to avoid recreating the deck list when the cards have not been modified
var current_decklist_cache: Array
# The operation can be either a remove or a progress
var operation: String
# How much it costs to perform the current operation
var operation_cost: int
# What type of pathos is used to perform the current operation
var operation_cost_type: String
# How much to progress a card during a progress operation
var progress_amount := 1
# If set to true, this deck will close and clear itself after the operation.
# This prevents having to hook onto the SelectionDeck's signal, just to close it
var auto_close := false
# Specifies a filter for which cards to display from the deck
# It needs to contain only objects of CardFilter class
var card_filters : Array
# If this list has entities, then instead of gathering deck cards from scratch,
# we make the player select from this list directly
# This allows for custom types of filtering
var prespecified_card_list := []

onready var _deck_operation_name := $VBC/OperationName/
onready var _deck_operation_cost := $VBC/OperationCost/
onready var _deck_preview_scroll := $VBC/ScrollContainer/
onready var _deck_preview_grid := $VBC/ScrollContainer/GridContainer
onready var _progress_cost := $"../VBC/VBC/HBC/Buttons/ProgressCost"


# Initiates an operation for card removal
func initiate_card_removal(cost: int = 0, cost_type: String = Terms.RUN_ACCUMULATION_NAMES.enemy) -> void:
	operation_cost = cost
	operation_cost_type = cost_type
	if operation != "remove":
		_clear_existing_cache()
	operation = "remove"
	_deck_operation_name.text = "Remove Card"
	_display()


# Initiates an operation for card progress.
func initiate_card_progress(cost: int = 0, cost_type: String = Terms.RUN_ACCUMULATION_NAMES.enemy, amount := 1) -> void:
	progress_amount = amount
	operation_cost = cost
	operation_cost_type = cost_type
	if operation != "progress":
		_clear_existing_cache()
	operation = "progress"
	_deck_operation_name.text = "Progress Card Upgrade"
	_display()

# Initiates an operation for card selection
func initiate_card_selection(cost: int = 0, cost_type: String = Terms.RUN_ACCUMULATION_NAMES.enemy) -> void:
	operation_cost = cost
	operation_cost_type = cost_type
	if operation != "selection":
		_clear_existing_cache()
	operation = "selection"
	_deck_operation_name.text = "Select Card"
	_display()


# Updates the label of the deck to show information to the player
# Such as the cost to perform the operation
func update_header(value: String) -> void:
	_deck_operation_cost.text = value


# Updates the colour of the header.
func update_color(value: Color) -> void:
	_deck_operation_cost.add_color_override("font_color", value)


# Pops up the deck display and populates the cards inside
func _display() -> void:
	var popup_size_x = (CFConst.CARD_SIZE.x * CFConst.THUMBNAIL_SCALE * _deck_preview_grid.columns)\
			+ _deck_preview_grid.get("custom_constants/vseparation") * _deck_preview_grid.columns
	rect_size = Vector2(popup_size_x,600)
	popup_centered()
	_populate_preview_cards()
	if OS.has_feature("debug") and not cfc.get_tree().get_root().has_node('Gut'):
		print("DEBUG INFO:SelectionDeck: Started Card Display with a %s card selection" % [_deck_preview_grid.get_child_count()])

# Goes through the player's deck and creates a card selection object
# for each card in it.
func _populate_preview_cards() -> void:
	if current_decklist_cache != globals.player.deck.list_all_cards():
		_clear_existing_cache()
		current_decklist_cache = globals.player.deck.list_all_cards()
		for index in range(globals.player.deck.cards.size()):
			var card_matches:= true
			var card_entry: CardEntry = globals.player.deck.cards[index]
			if prespecified_card_list.size() > 0:
				if not card_entry in prespecified_card_list:
					continue
			else:
				for f in card_filters:
					var filter: CardFilter = f
					if not filter.check_card(card_entry.properties):
						card_matches = false
				if operation == "progress":
					if card_entry.upgrade_progress >= card_entry.upgrade_threshold:
						card_matches = false
					if not CardFilter.new('_is_upgrade', false).check_card(card_entry.properties):
						card_matches = false
				if not card_matches:
					continue
			var card_preview_container = CARD_CHOICE_SCENE.instance()
			_deck_preview_grid.add_child(card_preview_container)
			card_preview_container.index = card_entry
			card_preview_container.setup(card_entry.instance_self(true))
			card_preview_container.connect(
					"card_selected", 
					self, 
					"_on_deck_card_selected", 
					[card_preview_container])
		if _deck_preview_grid.get_child_count() == 0:
			hide()
			if OS.has_feature("debug") and not cfc.get_tree().get_root().has_node('Gut'):
				print("DEBUG INFO:SelectionDeck: Automatically Hiding because no cards match criteria")

# Triggers the operation requested on the selected card, if the player has enough
# pathos
func _on_deck_card_selected(card_entry: CardEntry, deck_card_object) -> void:
	if not operation_cost <= globals.player.pathos.released[operation_cost_type]:
		return
	# We store that to send with the signal
	var signal_payload := {
		"card_entry": card_entry,
		"card_name": card_entry.card_name,
		"upgraded": card_entry.is_upgraded(),
		"progress": card_entry.upgrade_progress,
	}
	globals.player.pathos.released[operation_cost_type] -= operation_cost
	if operation == "remove":
		globals.player.deck.remove_card(card_entry)
		deck_card_object.queue_free()
	if operation == "progress":
		card_entry.upgrade_progress += progress_amount
		# We have to refresh the preview card to allow the player to see
		# The progress on the info panels.
		deck_card_object.refresh_preview_card()
	signal_payload["operation"] = operation
	emit_signal("operation_performed", signal_payload)
	if auto_close:
		globals.hide_all_previews()
		queue_free()
	elif operation == "progress" and card_entry.upgrade_progress >= card_entry.upgrade_threshold:
		deck_card_object.queue_free()
	# We assume card selection modifies the decklist somewhat. 
	# So we ensure the card list is refreshed
	current_decklist_cache.clear()

func _clear_existing_cache() -> void:
	for card in _deck_preview_grid.get_children():
		card.queue_free()
	current_decklist_cache.clear()
