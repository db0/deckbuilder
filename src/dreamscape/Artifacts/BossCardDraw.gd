extends Artifact


func _on_player_turn_started(_turn: Turn = null) -> void:
	var script = [{
		"name": "draw_cards",
		"tags": ["Curio"],
		"card_count": ArtifactDefinitions.BossCardDraw.amounts.draw_amount,
	}]
	execute_script(script)

func _on_scripting_completed(_artifact, _sceng) -> void:
	_send_trigger_signal()
