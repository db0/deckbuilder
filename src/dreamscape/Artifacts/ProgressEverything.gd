extends Artifact

func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.OVERWORLD:
		globals.player.deck.connect("card_added", self, "_on_card_added")


func _on_card_added(card_entry: CardEntry)  -> void:
	card_entry.upgrade_progress += ArtifactDefinitions.ProgressEverything.amounts.progress_amount
	_send_trigger_signal()
