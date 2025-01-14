extends NonCombatEncounter

const SLAY_MASTERIES := 3
const LEAVE_MASTERIES := 1
const journal_description = "I dreamt of a long spire, disappearing into the pregnant clouds above. "\
			+ "I realized I was now holding a weapon and could feel the need to slay whatever is within..."
const ai_prompts:= [
	"I dreamt of a long spire, disappearing into the clouds aboveI dreamt of a long spire, disappearing into the clouds above",
	"I was standing in front of a spire full of monsters. I needed to decide if I would climb up to slay them",
	"The stairway to the massive spire above was ominous, but I was here to slay",
]

var secondary_choices := {
		'slay': '[Slay]: {bcolor:+10 {anxiety_up}:}. Gain some {bcolor:{repressed_enemy}:}. {gcolor:Gain {slay_amount}:} {masteries}',
		'leave': '[Leave]: Gain some {bcolor:{repressed_nce}:}. {bcolor:Lose {leave_amount}:} {mastery}.',
	}

var nce_result_fluff := {
		'slay': "I started climbing. One horror after the next appeared before me until, "\
			+ "inenvitably I was slain myself. My vision of the spire faded and as I "\
			+ "felt into the next dream, I wondered if I could ever reach the top...",
		'leave': 'I am are not in the mood for whatever dark fantasy this is.',
	}


func _init():
	introduction.setup_with_vars("Slay The Spire",journal_description, "A Tower Full Of Monsters",ai_prompts)
	prepare_journal_art(load("res://assets/journal/nce/Slay the Spire.jpg"))
	
var pathos_type_enemy : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.enemy]
var pathos_type_nce : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.nce]

func begin() -> void:
	.begin()
	var scformat := Terms.RUN_ACCUMULATION_NAMES.duplicate()
	scformat["slay_amount"] = SLAY_MASTERIES
	scformat["leave_amount"] = LEAVE_MASTERIES
	_prepare_secondary_choices(secondary_choices, scformat)

func continue_encounter(key) -> void:
	match key:
		"slay":
			globals.player.damage += 10
			globals.player.pathos.available_masteries += SLAY_MASTERIES
			pathos_type_enemy.repressed += pathos_type_enemy.get_progression_average() * 2
		"leave":
			globals.player.pathos.available_masteries -= LEAVE_MASTERIES
			pathos_type_nce.repressed += pathos_type_enemy.get_progression_average() * 2
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])
