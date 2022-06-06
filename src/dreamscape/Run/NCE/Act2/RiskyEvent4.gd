# Gives three choices, paid with released pathos to get some rewards

extends NonCombatEncounter

var artifact_prep: ArtifactPrep
var highest_pathos: String
var pathos_type_highest: PathosType
var ignore_pathos : String = Terms.RUN_ACCUMULATION_NAMES.enemy
var pathos_type_ignored: PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.enemy]

var secondary_choices := {
		'help': '[Help]: Pay {bcolor:all your {pathos} ({amount}):}. {gcolor:Gain a random curio:}.',
		'ignore': '[Ignore]: Gain {bcolor:{ignore_amount} {ignore_pathos}:}. {gcolor:Gain a random curio:}. {bcolor:Become {perturbation}:}.',
	}

# TODO Result fluff
var nce_result_fluff := {
		'help': 'Helped: {curio}',
		'ignore': 'Ignored: {curio}',
	}


func _init():
	# TODO: Add story
	description = "<Risky Dream 4 - Story Fluff to be Done>. Select one Option...."


func begin() -> void:
	.begin()
	var pathos_org = globals.player.pathos.get_pathos_org()
	highest_pathos = pathos_org["highest_pathos"]["selected"]
	pathos_type_highest =  globals.player.pathos.pathi[highest_pathos]
	var scformat = {
		"perturbation": _prepare_card_popup_bbcode("Apathy", "apathetic"),
		"pathos": '{released_%s}' % [highest_pathos],
		"amount": floor(pathos_type_highest.released),
		"ignore_pathos": '{repressed_%s}' % [ignore_pathos],
		"ignore_amount": pathos_type_ignored.get_progression_average() * 2,
	}
	var disabled_choices = []
	if floor(pathos_type_highest.released) == 0:
		disabled_choices.append('help')
	_prepare_secondary_choices(secondary_choices, scformat, disabled_choices)

func continue_encounter(key) -> void:
	if key == "help":
		var amount = pathos_type_highest.released
		# Encounters Needed To Accumulate Amount
		var entam = amount / pathos_type_highest.get_progression_average()
		artifact_prep = ArtifactPrep.new(entam * 2, entam * 4, 1)
		# warning-ignore:return_value_discarded
		globals.player.add_artifact(artifact_prep.selected_artifacts[0].canonical_name)
		pathos_type_highest.spend_pathos(pathos_type_highest.released)
	else:
		artifact_prep = ArtifactPrep.new(1, 5, 1)
		# warning-ignore:return_value_discarded
		globals.player.add_artifact(artifact_prep.selected_artifacts[0].canonical_name)
		pathos_type_ignored.modify_repressed(pathos_type_ignored.get_progression_average() * 2, true)
		# warning-ignore:return_value_discarded
		globals.player.deck.add_new_card("Apathy")
	end()
	var fmt = {"curio": _prepare_artifact_popup_bbcode(artifact_prep.selected_artifacts[0].canonical_name, artifact_prep.selected_artifacts[0].name)}
	nce_result_fluff[key] = nce_result_fluff[key].format(fmt)
	globals.journal.display_nce_rewards(nce_result_fluff[key])

