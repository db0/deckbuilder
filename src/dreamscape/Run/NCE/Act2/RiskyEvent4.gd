# Gives three choices, paid with released pathos to get some rewards

extends NonCombatEncounter

var artifact_prep: ArtifactPrep
var highest_pathos: String
var ignore_pathos : String = Terms.RUN_ACCUMULATION_NAMES.enemy

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
	var scformat = {
		"perturbation": _prepare_card_popup_bbcode("Apathy", "apathetic"),
		"pathos": '{released_%s}' % [highest_pathos],
		"amount": floor(globals.player.pathos.released[highest_pathos]),
		"ignore_pathos": '{repressed_%s}' % [ignore_pathos],
		"ignore_amount": globals.player.pathos.get_progression_average(ignore_pathos) * 2,
	}
	var disabled_choices = []
	if floor(globals.player.pathos.released[highest_pathos]) == 0:
		disabled_choices.append('help')
	_prepare_secondary_choices(secondary_choices, scformat, disabled_choices)

func continue_encounter(key) -> void:
	if key == "help":
		var amount = globals.player.pathos.released[highest_pathos]
		# Encounters Needed To Accumulate Amount
		var entam = amount / globals.player.pathos.get_progression_average(highest_pathos)
		artifact_prep = ArtifactPrep.new(entam * 2, entam * 4, 1)
		# warning-ignore:return_value_discarded
		globals.player.add_artifact(artifact_prep.selected_artifacts[0].canonical_name)
		globals.player.pathos.modify_released_pathos(
				highest_pathos,
				-globals.player.pathos.released[highest_pathos],
				false)
	else:
		artifact_prep = ArtifactPrep.new(1, 5, 1)
		# warning-ignore:return_value_discarded
		globals.player.add_artifact(artifact_prep.selected_artifacts[0].canonical_name)
		globals.player.pathos.modify_repressed_pathos(
				ignore_pathos,
				globals.player.pathos.get_progression_average(ignore_pathos) * 2,
				true)
		# warning-ignore:return_value_discarded
		globals.player.deck.add_new_card("Apathy")
	end()
	var fmt = {"curio": _prepare_artifact_popup_bbcode(artifact_prep.selected_artifacts[0].canonical_name, artifact_prep.selected_artifacts[0].name)}
	nce_result_fluff[key] = nce_result_fluff[key].format(fmt)
	globals.journal.display_nce_rewards(nce_result_fluff[key])

