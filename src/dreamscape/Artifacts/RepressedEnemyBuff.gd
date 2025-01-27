extends Artifact

func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		scripting_bus.connect("battle_begun", self, "_on_battle_start")


func _on_battle_start():
	if not _activate():
		return
	var frustration_level = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.enemy].level
	var multiplier = frustration_level / ArtifactDefinitions.RepressedEnemyBuff.amounts.mastery_amount
	var script = [
		{
			"name": "apply_effect",
			"effect_name": Terms.ACTIVE_EFFECTS.buffer.name,
			"subject": "dreamer",
			"modification": ArtifactDefinitions.RepressedEnemyBuff.amounts.effect_stacks * multiplier,
			"tags": ["Curio", "Delayed"],
		},
	]
	execute_script(script)


func _on_scripting_completed(_artifact, _sceng) -> void:
	_send_trigger_signal()
