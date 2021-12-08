class_name PlayerInfo
extends PanelContainer



const CARD_PREVIEW_SCENE = preload("res://src/dreamscape/MainMenu/StartingCardPreviewObject.tscn")
const PATHOS_INFO_SCENE = preload("res://src/dreamscape/PathosEntryInfo.tscn")
const SETTINGS_SCENE = preload("res://src/dreamscape/MainMenu/SettingsMenu.tscn")

# Because we do not have a common PlayerInfo node throughout the whole game
# but rather we have different instances for it for each scene which
# covers the whole screen, we need to define the context in which a
# PlayerInfo scene added. We do that using this enum.
# This allows us to know which artifacts effect to turn off/on in the overall scene.
# This allows us to avoid a combat artifact node added to the Journal PlayerInfo
# triggering during battle.
export(ArtifactDefinitions.EffectContext) var context

var current_decklist_cache: Array
var pathos_infos := {}
var popup_settings : PopupPanel

onready var _deck_preview_popup := $DeckPreview
onready var _deck_preview_scroll := $DeckPreview/ScrollContainer/
onready var _deck_preview_grid := $DeckPreview/ScrollContainer/GridContainer
onready var _player_health_label := $HBC/Health
onready var _encounter_label := $HBC/Encounter
onready var _deck_button := $HBC/Deck
onready var _pathos_details := $PathosDetails
onready var _pathos_details_list := $PathosDetails/VBC
onready var _pathos_button := $HBC/Pathos
onready var _help := $Help
onready var _tutorial := $Help/Tutorial
onready var _artifacts := $HBC/Artifacts
onready var _version := $HBC/Version

func _ready() -> void:
	if globals.player.pathos:
		for entry in globals.player.pathos.repressed:
			var pinfo = PATHOS_INFO_SCENE.instance()
			_pathos_details_list.add_child(pinfo)
			pathos_infos[entry] = pinfo
			pinfo.setup(entry)
# warning-ignore:return_value_discarded
	globals.player.connect("artifact_added", self, "_on_artifact_added")
	_init_artifacts()
	_version.text = CFConst.GAME_VERSION
# warning-ignore:return_value_discarded
	get_viewport().connect("size_changed",self,"_on_Viewport_size_changed")


func _process(_delta: float) -> void:
	_update_health_label()
	_update_encounter_label()
	_update_deck_count()


func _on_Settings_pressed() -> void:
	SoundManager.play_se('click')
	if context == ArtifactDefinitions.EffectContext.BATTLE:
		cfc.game_paused = true
	popup_settings = PopupPanel.new()
	self.add_child(popup_settings)
	var settings_menu = SETTINGS_SCENE.instance()
	popup_settings.add_child(settings_menu)
	yield(get_tree(), "idle_frame")
	popup_settings.popup_centered_minsize()
	settings_menu.back_button.text = "Close"
	settings_menu.back_button.connect('pressed', self, '_on_Settings_hide')
	# warning-ignore:return_value_discarded
	popup_settings.connect('popup_hide', self, '_on_Settings_hide')


func _on_Settings_hide() -> void:
	SoundManager.play_se('back')
	popup_settings.queue_free()
	if context == ArtifactDefinitions.EffectContext.BATTLE:
		cfc.game_paused = false


func _on_Deck_pressed() -> void:
	SoundManager.play_se('book_open')
	var popup_size_x = (CFConst.CARD_SIZE.x * CFConst.THUMBNAIL_SCALE * _deck_preview_grid.columns * cfc.curr_scale)\
			+ _deck_preview_grid.get("custom_constants/vseparation") * _deck_preview_grid.columns
	_deck_preview_popup.rect_size = Vector2(popup_size_x,600)
	_deck_preview_popup.popup_centered()
	populate_preview_cards()


func populate_preview_cards() -> void:
	if current_decklist_cache != globals.player.deck.list_all_cards():
		for card in _deck_preview_grid.get_children():
			card.queue_free()
		current_decklist_cache =  globals.player.deck.list_all_cards()
		for preview_card_entry in globals.player.deck.cards:
			var card_preview_container = CARD_PREVIEW_SCENE.instance()
			_deck_preview_grid.add_child(card_preview_container)
			card_preview_container.setup(preview_card_entry.card_name)
			card_preview_container.display_card.deck_card_entry = preview_card_entry


func get_all_artifacts() -> Dictionary:
	var found_artifacts := {}
	for artifact in _artifacts.get_children():
		found_artifacts[artifact.canonical_name] = artifact
	return(found_artifacts)


func get_ordered_artifacts(ordered_effects: Dictionary) -> Dictionary:
	for artifact in _artifacts.get_children():
		match artifact.priority:
			Artifact.PRIORITY.ADD:
				ordered_effects.adders.append(artifact)
			Artifact.PRIORITY.MULTIPLY:
				ordered_effects.multipliers.append(artifact)
			Artifact.PRIORITY.SET:
				ordered_effects.setters.append(artifact)
	return(ordered_effects)


func _update_health_label() -> void:
	if cfc.NMAP.has("board")\
			and is_instance_valid(cfc.NMAP.board)\
			and is_instance_valid(cfc.NMAP.board.dreamer):
		_player_health_label.text =\
				str(cfc.NMAP.board.dreamer.damage) + '/' + str(cfc.NMAP.board.dreamer.health)
	else:
		_player_health_label.text = str(globals.player.damage) + '/' + str(globals.player.health)


func _update_encounter_label() -> void:
	_encounter_label.text = 'Encounter ' + str(globals.encounters.encounter_number)


func _update_deck_count() -> void:
	_deck_button.text = str(globals.player.deck.count_cards())


func _on_Pathos_pressed() -> void:
	SoundManager.play_se('click')
	_pathos_details.popup_centered_minsize()
	for entry in pathos_infos:
		pathos_infos[entry].update()
	_pathos_details.rect_global_position =\
		_pathos_button.rect_global_position + Vector2(-_pathos_details.rect_size.x,50)


func _on_Help_pressed() -> void:
	SoundManager.play_se('click')
	if context == ArtifactDefinitions.EffectContext.BATTLE:
		cfc.game_paused = true
	_tutorial.setup(context, _help)
	_tutorial.rect_size = get_viewport().size
	_help.popup_centered_minsize()


func _on_artifact_added(artifact_object: ArtifactObject) -> void:
	_instance_artifact(artifact_object, true)


# Instances and adds the artifact objects to this node
func _init_artifacts() -> void:
	for artifact_object in globals.player.artifacts:
		_instance_artifact(artifact_object)


func _instance_artifact(artifact_object: ArtifactObject, new_addition := false) -> void:
	var new_artifact = artifact_object.artifact_scene.instance()
	var artifact_active := false
	if context == artifact_object.context:
		artifact_active = true
	new_artifact.setup_artifact(artifact_object, artifact_active, new_addition)
	_artifacts.add_child(new_artifact)


func _input(event):
	if event.is_action_pressed("help"):
		_on_Help_pressed()


# Wipes the deck cache so that the cards can be recreated in the right size
func _on_Viewport_size_changed() -> void:
	current_decklist_cache = []

