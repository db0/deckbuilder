extends CombatEffect

func _ready():
# warning-ignore:return_value_discarded
	owning_entity.connect("entity_damaged", self, "_on_entity_damaged")

func _on_entity_damaged(entity, _amount, _trigger: Node, _tags: Array) -> void:
	if cfc.NMAP.board.turn.current_turn != cfc.NMAP.board.turn.Turns.PLAYER_TURN:
		return
	if entity_type != Terms.PLAYER:
		return
	var armor = [{
		"name": "apply_effect",
		"effect_name": Terms.ACTIVE_EFFECTS.armor.name,
		"subject": "trigger",
		"modification": cfc.card_definitions[name]\
			.get("_amounts",{}).get("concentration_stacks") * stacks,
		"tags": ["Combat Effect", "Concentration"],
	}]
	execute_script(armor, entity)
