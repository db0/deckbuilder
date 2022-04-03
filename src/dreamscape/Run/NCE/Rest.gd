class_name RestEncounter
extends NonCombatEncounter

# The amount by which the player's damage will be reduced
var rest_amount : float = 0.25

var secondary_choices := {
		'rest': '...and I left myself [url={"name": "rest","meta_type": "nce"}]fall into it.[/url]',
		'resist': '...and I struggled mightily to stave it off.',
	}


func _init():
	description = "I felt myself falling into a deep, dreamless torpor..."
	pathos_released = Terms.RUN_ACCUMULATION_NAMES.rest


func begin() -> void:
	.begin()
	globals.journal.add_nested_choices(secondary_choices)


func continue_encounter(key) -> void:
	match key:
		"rest":
			globals.player.damage -= int(globals.player.health * rest_amount)
			end()
			globals.journal.display_nce_rewards('')
		"resist":
			end()
			globals.journal.display_nce_rewards('')
#		"rest": globals.journal.add_nested_choices({3: "Test1", 4: "Test2"})
#		"resist": globals.journal.add_nested_choices({5: "Test3", 6: "Test4"})


func get_meta_hover_description(meta_tag: String) -> String:
	match meta_tag:
		"rest":
			globals.encounters.deep_sleeps += 1
			var healing_done = globals.player.health * rest_amount
			if healing_done > globals.player.damage:
				healing_done = globals.player.damage
			return("Removes anxiety equal to 25% of the max ({healing}), from the Dreamer."\
					.format({"healing": int(round(healing_done))}))
		_:
			return('')
