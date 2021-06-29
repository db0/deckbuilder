extends Board


const ENEMY_ENTITY_SCENE = preload("res://src/dreamscape/CombatElements/Enemies/EnemyEntity.tscn")

var end_turn : Button
var turn := Turn.new()
var dreamer: PlayerEntity
var activated_enemies: Array

onready var bottom_gui := $HBC
onready var post_battle_menu := $PostBattleMenu
onready var deck_pile: Pile = $Deck

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	counters = $HBC/Counters
	end_turn = $HBC/EndTurn
	cfc.map_node(self)
	# We use the below while to wait until all the nodes we need have been mapped
	# "hand" should be one of them.
	# We're assigning our positions programmatically,
	# instead of defining them on the scene.
	# This way any they will work with any size of viewport in a game.
	# Discard pile goes bottom right
	if not get_tree().get_root().has_node('Gut'):
		load_deck()
	turn.setup()
	dreamer = preload("res://src/dreamscape/CombatElements/PlayerEntity.tscn").instance()
	var dreamer_properties := {
		"Health": globals.player.health,
		"Damage": globals.player.damage,
		"Type": "Dreamer",
		"_texture_size_x": globals.PLAYER_COMBAT_ENTITY_SIZE.x,
		"_texture_size_y": globals.PLAYER_COMBAT_ENTITY_SIZE.y,
	}
	dreamer.setup("Dreamer", dreamer_properties)
	add_child(dreamer)
	dreamer.rect_position = Vector2(100,100)
# warning-ignore:unused_variable
	var torment = spawn_enemy("Gaslighter")
	var torment3 = spawn_enemy("Gaslighter")
	var torment2 = spawn_enemy("Gaslighter")
	torment2.rect_position = Vector2(800,100)
	torment3.rect_position = Vector2(200,300)
	yield(get_tree().create_timer(0.1), "timeout")
	bottom_gui.rect_position = cfc.NMAP.deck.position - Vector2(0,50)
#	dreamer.active_effects.mod_effect(ActiveEffects.NAMES.disempower, 5)
#	dreamer.active_effects.mod_effect(ActiveEffects.NAMES.poison, 5)
#	dreamer.active_effects.mod_effect(ActiveEffects.NAMES.empower, 2)
#	torment.active_effects.mod_effect(ActiveEffects.NAMES.empower, 5)

func spawn_enemy(enemy_name) -> EnemyEntity:
	var enemy_properties = EnemyDefinitions.ENEMIES.get(enemy_name)
	var enemy : EnemyEntity = ENEMY_ENTITY_SCENE.instance()
	enemy.setup(enemy_name, enemy_properties)
	enemy.entity_type = Terms.ENEMY
	add_child(enemy)
# warning-ignore:return_value_discarded
	enemy.connect("finished_activation", self, "_on_finished_enemy_activation")
# warning-ignore:return_value_discarded
	enemy.connect("entity_killed", self, "_enemy_died")
	enemy.rect_position = Vector2(500,100)
	return(enemy)

# This function is to avoid relating the logic in the card objects
# to a node which might not be there in another game
# You can remove this function and the FancyMovementToggle button
# without issues
func _on_FancyMovementToggle_toggled(_button_pressed) -> void:
#	cfc.game_settings.fancy_movement = $FancyMovementToggle.pressed
	cfc.set_setting('fancy_movement', $FancyMovementToggle.pressed)


func _on_OvalHandToggle_toggled(_button_pressed: bool) -> void:
	cfc.set_setting("hand_use_oval_shape", $OvalHandToggle.pressed)
	for c in cfc.NMAP.hand.get_all_cards():
		c.reorganize_self()


# Reshuffles all Card objects created back into the deck
func _on_ReshuffleAllDeck_pressed() -> void:
	reshuffle_all_in_pile(cfc.NMAP.deck)


func _on_ReshuffleAllDiscard_pressed() -> void:
	reshuffle_all_in_pile(cfc.NMAP.discard)

func reshuffle_all_in_pile(pile = cfc.NMAP.deck):
	for c in get_tree().get_nodes_in_group("cards"):
		if c.get_parent() != pile:
			c.move_to(pile)
			yield(get_tree().create_timer(0.1), "timeout")
	# Last card in, is the top card of the pile
	var last_card : Card = pile.get_top_card()
	if last_card._tween.is_active():
		yield(last_card._tween, "tween_all_completed")
	yield(get_tree().create_timer(0.2), "timeout")
	pile.shuffle_cards()


# Button to change focus mode
func _on_ScalingFocusOptions_item_selected(index) -> void:
	cfc.set_setting('focus_style', index)


# Button to make all cards act as attachments
func _on_EnableAttach_toggled(button_pressed: bool) -> void:
	for c in get_tree().get_nodes_in_group("cards"):
		c.is_attachment = button_pressed


func _on_Debug_toggled(button_pressed: bool) -> void:
	cfc._debug = button_pressed

func get_all_scriptables() -> Array:
	return(get_tree().get_nodes_in_group("CombatEntities") + get_all_cards())


# Loads the player's deck
func load_deck() -> void:
	for card in globals.player.deck.instance_cards():
		$Deck.add_child(card)
		#card.set_is_faceup(false,true)
		card._determine_idle_state()
		deck_pile.shuffle_cards(false)
	yield(get_tree().create_timer(0.3), "timeout")
	cfc.NMAP.hand.refill_hand()


func _on_player_turn_started(_turn: Turn) -> void:
	while not  cfc.NMAP.hand.is_hand_refilled:
		yield(cfc.NMAP.hand, "hand_refilled")
	while cfc.NMAP.hand.are_cards_still_animating():
		yield(get_tree().create_timer(0.3), "timeout")
	end_turn.disabled = false

func _on_player_turn_ended(_turn: Turn) -> void:
	end_turn.disabled = true
	activated_enemies.clear()
	turn.start_enemy_turn()
	yield(get_tree().create_timer(1), "timeout")
	# I want the enemies to activate serially
	for enemy in get_tree().get_nodes_in_group("EnemyEntities"):
#		print_debug("Activating Intents: " + enemy.canonical_name)
		enemy.activate()

func _on_finished_enemy_activation(enemy: EnemyEntity) -> void:
	if not enemy in activated_enemies:
		activated_enemies.append(enemy)
	if activated_enemies.size() == get_tree().get_nodes_in_group("EnemyEntities").size():
		turn.end_enemy_turn()
		turn.start_player_turn()

func _enemy_died() -> void:
	yield(get_tree().create_timer(1), "timeout")
	if get_tree().get_nodes_in_group("EnemyEntities").size() == 0:
		complete_battle()
		
func complete_battle() -> void:
	globals.player.damage = dreamer.damage
	post_battle_menu.display()

