extends Artifact

func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		EventBus.connect("battle_begun", self, "_on_battle_start")


func _on_player_turn_started(_turn: Turn = null) -> void:
	if _is_activated:
		return
	var script = [
		{
			"name": "mod_counter",
			"counter_name": "immersion",
			"modification": ArtifactDefinitions.ThickImmersion.amounts.immersion_amount,
			"tags": ["New Turn", "Curio"],
		},
	]
	execute_script(script)

# Connecting the signal here ensures the artifact will not be disabled at the start of combat
func _on_battle_start() -> void:
	cfc.NMAP.deck.connect("shuffle_completed", self, "_on_first_reshuffle")


func _on_first_reshuffle(_pile: Pile) -> void:
	# warning-ignore:return_value_discarded
	_activate()
	cfc.NMAP.deck.disconnect("shuffle_completed", self, "_on_first_reshuffle")
	var script = [
		{
			"name": "apply_effect",
			"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
			"subject": "dreamer",
			"modification": ArtifactDefinitions.ThickImmersion.amounts.effect_stacks,
			"tags": ["Curio"],
		},
	]
	execute_script(script)
	_send_trigger_signal()
