# Gives three choices to gain pathos. Each with increasing amount of anxiety gained

extends NonCombatEncounter

const DAMAGE_AMOUNT := 7

var secondary_choices := {
		'intrerpret': '[intrerpret]: {bcolor:+{damage_amount} {anxiety_up}:}. {gcolor:Gain {subconscious}:}',
		'avoid': '[avoid]: Gain {gcolor:{lowest_pathos_amount} {lowest_pathos}:}.',
	}
	
var nce_result_fluff := {
		'intrerpret': '<Intrerpret Choice Result - Story Fluff to be Done>',
		'avoid': '<Avoid Choice Result - Story Fluff to be Done>',
	}

var lowest_pathos: String
var lowest_pathos_amount: float
var pathos_type_lowest : PathosType

func _init():
	description = "<Subconscious - Story Fluff to be Done>. Select one Option...."

func begin() -> void:
	.begin()
	var pathos_org = globals.player.pathos.get_pathos_org("level", true)
	pathos_type_lowest = pathos_org["lowest_pathos"]["selected"]
	lowest_pathos = pathos_type_lowest.name
	lowest_pathos_amount = round(pathos_type_lowest.get_progression_average()\
			* 9 * CFUtils.randf_range(0.8,1.2))
	var scformat = {
		"lowest_pathos": '{released_%s}' % [lowest_pathos],
		"lowest_pathos_amount":  "a large amount",
		"damage_amount":  DAMAGE_AMOUNT,
		"subconscious": _prepare_card_popup_bbcode("Subconscious", " an insight into your own mind."),
	}
	_prepare_secondary_choices(secondary_choices, scformat)

func continue_encounter(key) -> void:
	match key:
		"avoid":
			pathos_type_lowest.released += lowest_pathos_amount
		"intrerpret":
			# warning-ignore:return_value_discarded
			globals.player.damage += DAMAGE_AMOUNT
			globals.player.deck.add_new_card("Subconscious")
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])
