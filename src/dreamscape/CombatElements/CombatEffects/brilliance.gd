extends CombatEffect

func _ready() -> void:
	cfc.NMAP.deck.connect("shuffle_completed", self, "_on_deck_shuffled")
	
func _on_deck_shuffled(_deck) -> void:
	var core_amount : int = cfc.card_definitions[name]\
			.get("_amounts",{}).get("concentration_defence")
	var brilliance = [{
				"name": "assign_defence",
				"subject": "dreamer",
				"amount": core_amount * stacks,
				"tags": ["Combat Effect", "Concentration"],
			}]
	execute_script(brilliance)
