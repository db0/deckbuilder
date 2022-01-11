extends "res://tests/HUT_TormentTestClass.gd"

class TestVoid:
	extends "res://tests/HUT_TormentEffectsTestClass.gd"

	func _init() -> void:
		test_card_names = [
			"Void",
		]
		var test_effect := {
				"name": Terms.ACTIVE_EFFECTS["void"].name,
				"amount": 2,
			}
		effects_to_play.append(test_effect)


	func test_void():
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		yield(yield_for(1.5), YIELD)
		assert_eq(count_card_names("Lacuna"), 2,
				"2 Lacuna as spawned per played Understanding")
#		execute_with_target(cards[0], torments[0])
	#	_torment1.active_effects.mod_effect(Terms.ACTIVE_EFFECTS["void"].name, 1)
#		pause_before_teardown()

