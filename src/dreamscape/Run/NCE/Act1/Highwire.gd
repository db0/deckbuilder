extends NonCombatEncounter

const PATHOS_USED = Terms.RUN_ACCUMULATION_NAMES.artifact
var artifact_prep: ArtifactPrep
const journal_description = "I found myself on a small platform atop a circus tent with only a tightrope ahead of me. The crowd below was cheering me on."
const ai_prompts:= [
	"The tightrope I was standing on was stretching way to far ahead and behind me, while the ground was barely visible"
]

var secondary_choices := {
		'accept': '[Accept]: 40% chance to gain a random {artifact}. [color=#FF3333]Become {perturbation}[/color].',
		'decline': '[Decline]: [color=#FF3333]+10[/color] {anxiety_up}. [color=#FF3333]Lose some {repressed_pathos}.',
	}

var nce_result_fluff := {
		'accept_success': 'I made it across, and found {curio} at the other size.',
		'accept_fail': 'A clown distracted me and I began to fall. Was there a safety net?',
		'decline': 'The crowd groaned as I climbed down from the platform.',
	}
	
# For controlling chances during testing
var _testing_rng = -1

func _init():
	introduction.setup_with_vars("Highwire",journal_description, "Precarious Balancing", ai_prompts)
	prepare_journal_art(load("res://assets/journal/nce/Highwire.jpg"))

func begin() -> void:
	.begin()
	var scformat = {
		"perturbation": _prepare_card_popup_bbcode("Terror", "terrified"),
		"repressed_pathos": '{repressed_%s}' % [PATHOS_USED],
	}
	_prepare_secondary_choices(secondary_choices, scformat)

func continue_encounter(key) -> void:
	var result: String
	if key == "accept":
		result = nce_result_fluff['accept_fail']
		var rngesus = CFUtils.randi_range(1,100)
		if _testing_rng >= 0:
			rngesus = _testing_rng
		if rngesus <= 40:
			var pathos_type: PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.nce]
			var accumulated = pathos_type.repressed / 4
			artifact_prep = ArtifactPrep.new(accumulated/2, accumulated, 1)
# warning-ignore:return_value_discarded
			globals.player.add_artifact(artifact_prep.selected_artifacts[0].canonical_name)
			var fmt = {"curio": _prepare_artifact_popup_bbcode(artifact_prep.selected_artifacts[0].canonical_name, artifact_prep.selected_artifacts[0].name)}
			result = nce_result_fluff['accept_success'].format(fmt)
		# warning-ignore:return_value_discarded
		globals.player.deck.add_new_card("Terror")
	else:
		result = nce_result_fluff['decline']
		globals.player.damage += 10
		var pathos_type: PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.artifact]
		var amount_lost = pathos_type.get_progression_average() * 2 * CFUtils.randf_range(0.8,1.2)
		pathos_type.modify_repressed(-amount_lost, true)
	end()
	globals.journal.display_nce_rewards(result)
