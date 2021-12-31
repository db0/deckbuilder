class_name CombatEncounter
extends SingleEncounter

var reward_description: String
var current_combat: ViewportCardFocus
var difficulty: String = "medium"
	
func game_over() -> void:
	end()
	current_combat.queue_free()
	yield(cfc.get_tree().create_timer(0.1), "timeout")
	.game_over()
