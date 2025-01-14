extends TextureRect

const README := "Thank you for trying out Hypnagonia!\n\n"\
		+ "This game is a Free Software 'Spire-like' deckbuilder. "\
		+ "This means it's free to download, use, modify and redistribute\n\n"\
		+ "This game is a heavy work in progress. At this point many bugs are expected "\
		+ "and most of the expected features are missing.\n"\
		+ "However whatever is there is fully playable.\n\n"\
		+ "Tutorials, Campaign and lots more card groups will be coming out soon."

const SUBTITLES := [
	"A deckbuilding therapy session",
	"Therapy through nightmares",
	"That sinking stone in your heart",
	"The weight of the mind",
	"A rhapsody of reverie and retrospection",
]

# The time it takes to switch from one menu tab to another
const menu_switch_time = 0.35

onready var v_buttons := $MainMenu/VBox/Center/VButtons
onready var readme_button := $MainMenu/CornerElements/LeftSide/Readme
onready var credits_button := $MainMenu/CornerElements/LeftSide/Credits
onready var settings_button := $MainMenu/CornerElements/RightSide/Settings
onready var exit_button := $MainMenu/CornerElements/LeftSide/Exit
onready var continue_button := $MainMenu/VBox/Center/VButtons/Continue
onready var main_menu := $MainMenu
#onready var settings_menu := $SettingsMenu
onready var card_library := $CardLibrary
onready var settings := $Settings
onready var new_game := $NewGame
onready var _readme_label := $ReadMe/Label
onready var _readme_popup := $ReadMe
onready var _credits_label := $Credits/CreditsLabel
onready var _credits_popup := $Credits
onready var menu_tween := $MenuTween
onready var bg_tween := $BGTween
onready var _subtitle := $MainMenu/VBox/Margin/VBoxContainer/Subtitle
onready var _version := $MainMenu/CornerElements/RightSide/Version
onready var _bg_shader := $Shader
onready var _title := $MainMenu/VBox/Margin/VBoxContainer/Title







# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Hypnagonia Version: " + CFConst.GAME_VERSION)
	for option_button in v_buttons.get_children()\
			+ [settings_button, readme_button, credits_button, exit_button]:
		if option_button.has_signal('pressed'):
			option_button.connect('pressed', self, 'on_button_pressed', [option_button.name])
	new_game.rect_position.x = get_viewport().size.x
	card_library.rect_position.x = -get_viewport().size.x
	settings.rect_position.x = -get_viewport().size.x
	new_game.back_button.connect("pressed", self, "switch_to_main_menu", [new_game])
#	new_game.recover_prebuilts.connect("pressed", self, "_on_PreBuilts_pressed")
	card_library.back_button.connect("pressed", self, "switch_to_main_menu", [card_library])
	settings.get_node("SettingsMenu").back_button.connect("pressed", self, "switch_to_main_menu", [settings])
	# warning-ignore:return_value_discarded
	get_viewport().connect("size_changed", self, '_on_Menu_resized')
	_readme_label.text = README
	randomize()
	cfc.game_rng_seed = CFUtils.generate_random_seed()
	if not cfc.game_settings.has('Client UUID'):
		cfc.set_setting('Client UUID', UUID.v4())
	SUBTITLES.shuffle()
	continue_button.visible = globals.game_save.save_file_exists()
	_subtitle.text = SUBTITLES[0]
	_version.text = CFConst.GAME_VERSION
	globals.music.switch_scene_music('main')
	_title.texture = CFUtils.convert_texture_to_image(_title.texture)
	_on_Menu_resized()


func on_button_pressed(_button_name : String) -> void:
	match _button_name:
		"NewGame":
			_switch_bg(HUtils.get_random_background('dark').image)
			SoundManager.play_se('click')
			switch_to_tab(new_game)
		"Continue":
			_load_game()
		"QuickStart":
			SoundManager.play_se(Sounds.get_randomize_sound())
			new_game.randomize_aspect_choices()
			new_game.start_new_game()
		"Readme":
			SoundManager.play_se('click')
			_readme_popup.rect_size = _readme_label.rect_size
			_readme_popup.popup_centered_minsize()
		"Credits":
			SoundManager.play_se('click')
			_credits_popup.rect_size = _readme_label.rect_size
			_credits_popup.popup_centered_minsize()
		"CardLibrary":
			_switch_bg(HUtils.get_random_background('dark').image)
			SoundManager.play_se(Sounds.get_shove_sound())
			switch_to_tab(card_library)
		"Settings":
			_switch_bg(HUtils.get_random_background('dark').image)
			SoundManager.play_se(Sounds.get_shove_sound())
			switch_to_tab(settings)
		"Exit":
			SoundManager.play_se('click')
			get_tree().quit()


func switch_to_tab(tab: Control) -> void:
	var main_position_x : float
	match tab:
		new_game:
			main_position_x = -get_viewport().size.x
		card_library, settings:
			main_position_x = get_viewport().size.x
	menu_tween.interpolate_property(main_menu,'rect_position:x',
			main_menu.rect_position.x, main_position_x, menu_switch_time,
			Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	menu_tween.interpolate_property(tab,'rect_position:x',
			tab.rect_position.x, 0, menu_switch_time,
			Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	menu_tween.start()


func switch_to_main_menu(tab: Control) -> void:
	SoundManager.play_se(Sounds.get_shove_sound())
	cfc.hide_all_previews()
	var tab_position_x : float
	match tab:
		new_game:
			tab_position_x = get_viewport().size.x
		card_library, settings:
			tab_position_x = -get_viewport().size.x
	menu_tween.interpolate_property(tab,'rect_position:x',
			tab.rect_position.x, tab_position_x, menu_switch_time,
			Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	menu_tween.interpolate_property(main_menu,'rect_position:x',
			main_menu.rect_position.x, 0, menu_switch_time,
			Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	menu_tween.start()
	_switch_bg(HUtils.get_random_background('dark').image)


func _on_DeckBuilder_Back_pressed() -> void:
	switch_to_main_menu(card_library)


func _on_Menu_resized() -> void:
	for tab in [main_menu, card_library, new_game, settings, _bg_shader]:
		if is_instance_valid(tab):
			tab.rect_size = get_viewport().size
			if tab.rect_position.x < 0.0:
					tab.rect_position.x = -get_viewport().size.x
			elif tab.rect_position.x > 0.0:
					tab.rect_position.x = get_viewport().size.x
#			if tab == main_menu:
#				print_debug([tab.rect_size,get_viewport().size])

func _load_game() -> void:
	SoundManager.play_se('button_click')
	menu_tween.interpolate_property($FadeToBlack,
			'modulate:a', 0, 1, 1,
			Tween.TRANS_SINE, Tween.EASE_IN)
	menu_tween.start()
	yield(menu_tween, "tween_all_completed")
	if OS.has_feature("debug") and not cfc.is_testing:
		print("DEBUG INFO:Main: Loading game.")
	globals.game_save.load_state()


func _input(event):
	if event.is_action_pressed("debug"):
		globals.game_save.load_state()
	if event.is_action_pressed("Show FPS"):
		print(Engine.get_frames_per_second())
	if event.is_action_pressed("init_debug_game"):
		match OS.get_name():
			"Windows":
				print('Card Library Saved in %APPDATA%\\Godot\\app_userdata\\Hypnagonia\\library.json')
			"X11":
				print('Card Library Saved in ${HOME}/.local/share/godot/app_userdata/Hypnagonia/library.json')
		var ordered_list := []
		var card_names_for_art_export := {}
		for libcard in cfc.card_definitions:
			var card_export := _process_card_export(libcard)
			if card_export.get("_is_upgrade", false):
				continue
			if cfc.card_definitions[libcard].get("_illustration") == 'Nobody':
				var card_archetypes := Aspects.get_card_archetypes(libcard)
				if card_archetypes.size() == 0:
					var type = cfc.card_definitions[libcard].Type
					card_names_for_art_export[type] = card_names_for_art_export.get(type, [])
					card_names_for_art_export[type].append(libcard)
				for archetype in card_archetypes:
					card_names_for_art_export[archetype] = card_names_for_art_export.get(archetype, [])
					card_names_for_art_export[archetype].append(libcard)
			ordered_list.append(card_export)
			if card_export.has("_upgrades"):
				for upgrade_name in card_export["_upgrades"]:
					ordered_list.append(_process_card_export(upgrade_name))
		var library_export = File.new()
		library_export.open("user://library.json",File.WRITE)
		library_export.store_string(JSON.print(ordered_list, '\t'))
		library_export.close()
		library_export.open("user://cards_names_without_art.json",File.WRITE)
		library_export.store_string(JSON.print(card_names_for_art_export, '\t'))
		library_export.close()
		var all_t = _export_torments()
		var torments_dict = all_t[0]
		var torments_prompts = all_t[1]		
		library_export.open("user://torments_export.json",File.WRITE)
		library_export.store_string(JSON.print(torments_dict, '\t'))
		library_export.close()
		library_export.open("user://torments_aiprompts.json",File.WRITE)
		library_export.store_string(JSON.print(torments_prompts, '\t'))
		library_export.close()
		library_export.open("user://torments_softprompt.txt",File.WRITE)
		library_export.store_string(get_torment_softprompt_training())
		library_export.close()
		library_export.open("user://memories_export.json",File.WRITE)
		library_export.store_string(JSON.print(_export_memories(), '\t'))
		library_export.close()


	

func _process_card_export(card_name: String) -> Dictionary:
	var card_entry = cfc.card_definitions[card_name].duplicate(true)
	card_entry['Name'] = card_name
	card_entry['Abilities'] = card_entry['Abilities'].format(card_entry.get('_amounts', {}))
	card_entry.erase("_amounts")
	card_entry.erase("_effects_info")
	card_entry.erase("_illustration")
	card_entry.erase("_keywords")
	card_entry['archetypes'] = Aspects.get_card_archetypes(card_name)
	return(card_entry)


func _switch_bg(bg_image: ImageTexture) -> void:
	bg_tween.remove_all()
	bg_tween.interpolate_property(self,'self_modulate',
			self_modulate, Color(0,0,0), 0.20,
			Tween.TRANS_QUAD, Tween.EASE_IN)
			
	bg_tween.interpolate_property(_bg_shader,'self_modulate:a',
			_bg_shader.self_modulate.a, 0, 0.20,
			Tween.TRANS_QUAD, Tween.EASE_IN)
	bg_tween.start()
	
	
	yield(bg_tween, "tween_all_completed")
	texture = bg_image
	self_modulate = Color(0,0,0)
	bg_tween.interpolate_property(self,'self_modulate',
			self_modulate, Color(1,1,1), 0.20,
			Tween.TRANS_SINE, Tween.EASE_OUT)
			
	bg_tween.interpolate_property(_bg_shader,'self_modulate:a',
			_bg_shader.self_modulate.a, 0.7, 0.20,
			Tween.TRANS_QUAD, Tween.EASE_OUT)
	bg_tween.start()


func _export_torments() -> Array:
	var tdict: Dictionary = {
		'Basic Torments': {},
		'Elite Torments': {},
		'Bosses': {},
	}
	var sdict = {}
	for act in [Act1, Act2, Act3]:
		for e in act.ENEMIES:
			var enemy = act.ENEMIES[e]
			for torment in enemy.enemies.medium:
				if not tdict['Basic Torments'].has(torment.definition.Name):
					tdict['Basic Torments'][torment.definition.Name] = {}
					tdict['Basic Torments'][torment.definition.Name]['Journal Description'] = _remove_bburl_from_desc(enemy.journal_description)
					if enemy.has("ai_prompts"):
						tdict['Basic Torments'][torment.definition.Name]['AI prompts'] = enemy.ai_prompts
						sdict[enemy.name] = {'prompts':{}}
						sdict[enemy.name]['prompts']["journal_choice"] = enemy.ai_prompts
						if enemy.get("title"):
							sdict[enemy.name]["title"] = enemy.title
					tdict['Basic Torments'][torment.definition.Name]['Type'] = torment.definition.Type
		for e in act.ELITES:
			var enemy = act.ELITES[e]
			if not tdict['Elite Torments'].has(enemy.name):
				tdict['Elite Torments'][enemy.name] = {}
				tdict['Elite Torments'][enemy.name]['Journal Description'] = enemy.journal_description
				sdict[enemy.name] = {'prompts':{}}
				if enemy.get("ai_prompts"):
					sdict[enemy.name]['prompts']["journal_choice"] = enemy.ai_prompts
				if enemy.get("title"):
					sdict[enemy.name]["title"] = enemy.title
				for s in enemy.scenes:
					var scene :AdvancedEnemyEntity = s.instance()
					tdict['Elite Torments'][enemy.name]['Type'] = scene.PROPERTIES.Type
					scene.queue_free()
		for e in act.BOSSES:
			var enemy = act.BOSSES[e]
			if not tdict['Bosses'].has(enemy.name):
				tdict['Bosses'][enemy.name] = {}
				tdict['Bosses'][enemy.name]['Journal Description'] = enemy.journal_description
				sdict[enemy.name] = {'prompts':{}}
				if enemy.get("ai_prompts"):
					sdict[enemy.name]['prompts']["journal_choice"] = enemy.ai_prompts
				if enemy.get("title"):
					sdict[enemy.name]["title"] = enemy.title
				for s in enemy.scenes:
					var scene :AdvancedEnemyEntity = s.instance()
					tdict['Bosses'][enemy.name]['Type'] = scene.PROPERTIES.Type
					scene.queue_free()
	return([tdict,sdict])


func get_torment_softprompt_training() -> String:
	var torments_dict = _export_torments()[0]
	var softprompt_export := ''
	var torment_template := "[ Keywords: {name},{type} ]\n{description}<|endoftext|>"
	for d in torments_dict:
		var diff_convert:= {
			"Basic Torments": "Torment",
			"Elite Torments": "Elite",
			"Bosses": "Adversary",
		}
		var diff = diff_convert[d]
		for t in torments_dict[d]:
			var description :String = _remove_bburl_from_desc(torments_dict[d][t]["Journal Description"])
			var tname :String= t.replace("_", " ")
			var fmt_dict := {
				"difficulty": diff,
				"type": torments_dict[d][t]["Type"],
				"name": tname,
				"description": description
			}
			softprompt_export += torment_template.format(fmt_dict)
	return(softprompt_export)

func _remove_bburl_from_desc(description: String) -> String:
	description = description.replace("\n\n", "\n")
	description = description.replace("[/url]", "")
	description = description.replace("[url={torment_tag1}]", "")
	description = description.replace("[url={torment_tag2}]", "")
	description = description.replace("[url={torment_tag3}]", "")
	description = description.replace("[url={torment_tag4}]", "")
	description = description.replace("[url={torment_tag5}]", "")
	return(description)

func _export_memories() -> Array:
	var mret: Array = []
	for mem in MemoryDefinitions.get_complete_memories_array():
		mret.append(mem.name)
	return(mret)


func _on_Credits_pressed() -> void:
	print_debug("name")
