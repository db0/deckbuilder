# Description TBD

extends NonCombatEncounter

var shader := load("res://shaders/Roscharch.shader")

var secondary_choices := {
		'passion fruit': '[A Passion Fruit]: Gain some {gcolor:{released_artifact}:}.',
		'orange': '[An Orange]:  Gain some {gcolor:{released_elite}:}.',
		'banana': '[A Banana]: Gain some {gcolor:{released_rest}:}.',
	}

var nce_resul_fluff := "[i]I understand. You're {adjective} your {noun}.[/i]"

var mad_lib_adjectives = [
	"deeply worried about",
	"very excited about",
	"secretly shameful of",
]
var mad_lib_nouns = [
	"dieting habits",
	"phobias",
	"night activities",
	"romance novels",
]

func _init():
	description = "I was rushing to my second appointment with the Pop Psychologist.\n"\
			+ "I took a seat in an overly [color=#FF0038]carmine fainting couch[/color].\n\n"\
			+ "[i]How have you been doing since your last visit? We should to revisit the Rorschach test.\n"\
			+ "What do you see in this picture?[/i]\n\n"\
			+ "My eyes were getting tired from straining..."

func begin() -> void:
	.begin()
	var _shader_params := {
		'tint': HUtils.rnd_color(true, 255),
		'time_offset': CFUtils.randf_range(0, 10000)
	}
	prepare_shader_art(shader, _shader_params)
	_prepare_secondary_choices(secondary_choices, {})

func continue_encounter(key) -> void:
	var pathos_type : PathosType
	var multiplier : float
	match key:
		"passion fruit":
			pathos_type = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.artifact]
			multiplier = 5
		"orange":
			pathos_type = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.elite]
			multiplier = 3
		"banana":
			pathos_type = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.rest]
			multiplier = 5
	pathos_type.released += pathos_type.get_progression_average() * multiplier * CFUtils.randf_range(0.8,1.2)
	CFUtils.shuffle_array(mad_lib_adjectives)
	CFUtils.shuffle_array(mad_lib_nouns)
	var adlib_format = {
		"adjective": mad_lib_adjectives[0],
		"noun": mad_lib_nouns[0],
	}
	globals.encounters.run_changes.unlock_nce("PopPsychologist3", "easy")
	end()
	globals.journal.display_nce_rewards(nce_resul_fluff.format(adlib_format))
