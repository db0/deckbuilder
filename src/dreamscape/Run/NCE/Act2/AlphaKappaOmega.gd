# Gives three choices, paid with released pathos to get some rewards

extends NonCombatEncounter

var secondary_choices := {
		'omega': '[omega]: {omega} Lose {bcolor:{lowest_pathos_cost} {lowest_pathos}:}. {gcolor:{omega_desc}:}',
		'kappa': '[kappa]: {frozen} Lose {bcolor:{highest_pathos_cost} {highest_pathos}:}. {gcolor:{kappa_desc}:}',
		'alpha': '[alpha]: {alpha} Lose {bcolor:{middle_pathos_cost} {middle_pathos}:}. {gcolor:{alpha_desc}:}',
		'leave': '[Leave]: Nothing Happens.',
	}
var pathos_choice_payments := {}
var card_choice_descriptions := {
		'alpha': 'Choose a card which always starts at the top of your deck.',
		'kappa': 'Choose a card which is not discarded at the end of your turn.',
		'omega': 'Choose a card which always starts at the bottom of your deck.',
}

func _init():
	description = "I came across a faceless monk with inumerable arms." \
		+ " \"I am the monk Chance,\" the monk seemed to say from nowhere, \"disciple of the goddess Lady Luck.\"" \
		+ "\"Would you like the power to control your fate?\""

func begin() -> void:
	.begin()
	var pathos_org = globals.player.pathos.get_pathos_org()
#	print_debug(pathos_org)
	var highest_pathos = pathos_org["highest_pathos"]["selected"]
	var lowest_pathos = pathos_org["lowest_pathos"]["selected"]
	var middle_pathos = pathos_org["middle_pathos"]["selected"]
	var pathos_type_lowest: PathosType = globals.player.pathos.pathi[lowest_pathos]
	var pathos_type_middle: PathosType = globals.player.pathos.pathi[middle_pathos]
	var pathos_type_highest: PathosType = globals.player.pathos.pathi[highest_pathos]
	var lowest_pathos_cost = pathos_type_lowest.get_progression_average() * 2
	var middle_pathos_cost = pathos_type_middle.get_progression_average() * 5
	var highest_pathos_cost = pathos_type_highest.get_progression_average() * 7
	var scformat = {
		"lowest_pathos": '{released_%s}' % [lowest_pathos],
		"lowest_pathos_cost":  lowest_pathos_cost,
		"middle_pathos": '{released_%s}' % [middle_pathos],
		"middle_pathos_cost":  middle_pathos_cost,
		"highest_pathos": '{released_%s}' % [highest_pathos],
		"highest_pathos_cost":  highest_pathos_cost,
		"alpha_desc": card_choice_descriptions.alpha,
		"kappa_desc": card_choice_descriptions.kappa,
		"omega_desc": card_choice_descriptions.omega,
	}
	pathos_choice_payments["omega"]  = {
		"pathos": lowest_pathos,
		"pathos_type": pathos_type_lowest,
		"cost": lowest_pathos_cost
	}
	pathos_choice_payments["alpha"] = {
		"pathos": middle_pathos,
		"pathos_type": pathos_type_middle,
		"cost": middle_pathos_cost
	}
	pathos_choice_payments["kappa"] = {
		"pathos": highest_pathos,
		"pathos_type": pathos_type_highest,
		"cost": highest_pathos_cost
	}
	var disabled_choices := []
	for type in ['alpha', 'kappa', 'omega']:
		secondary_choices[type] = secondary_choices[type].format(scformat)
		if globals.player.pathos.released[pathos_choice_payments[type]["pathos"]]\
				< pathos_choice_payments[type]["cost"]:
			disabled_choices.append(type)
	_prepare_secondary_choices(secondary_choices, scformat, disabled_choices)

func continue_encounter(key) -> void:
	var tag_name: String
	var card_choice_description
	match key:
		"alpha":
			tag_name = Terms.GENERIC_TAGS.alpha.name
			card_choice_description = card_choice_descriptions.alpha
		"kappa":
			tag_name = Terms.GENERIC_TAGS.frozen.name
			card_choice_description = card_choice_descriptions.kappa
		"omega":
			tag_name = Terms.GENERIC_TAGS.omega.name
			card_choice_description = card_choice_descriptions.omega
	if key != "leave":
		var card_filters = [CardFilter.new('Tags', tag_name, 'ne')]
#		modified_card.modify_property(property, new_value)
		var selection_deck : SelectionDeck = globals.journal.spawn_selection_deck()
		selection_deck.popup_exclusive = true
		# warning-ignore:return_value_discarded
		selection_deck.connect("operation_performed", self, "_on_card_selected", [tag_name])
		selection_deck.auto_close = true
		selection_deck.card_filters = card_filters
		selection_deck.initiate_card_selection(0)
		selection_deck.update_header(card_choice_description\
				.format(Terms.get_bbcode_formats(18)))
		selection_deck.update_color(Color(0,1,0))
		var pathos_type : PathosType = pathos_choice_payments[key]["pathos_type"]
		pathos_type.lose_released_pathos(pathos_choice_payments[key]["cost"])
	end()
	globals.journal.display_nce_rewards('')

func _on_card_selected(operation_details: Dictionary, tag_name: String) -> void:
	operation_details.card_entry.modify_property('Tags', tag_name, true)
