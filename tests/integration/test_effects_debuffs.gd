extends "res://tests/HUT_TormentEffectsTestClass.gd"

# For checking
#yield(yield_for(5.1), YIELD)


class TestDrain:
	extends "res://tests/HUT_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.drain.name
	func _init() -> void:
		test_card_names = [
			"Interpretation",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": 2,
			}
		]

	func test_drain_general():
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 0,
				"Dreamer should have already used %s stacks" % [effect])
		assert_eq(counters.counters.immersion, 1,
				"Dreamer's energy decreased")

	func test_drain_opposite():
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.buffer.name, 4,  '')
		yield(yield_to(get_tree(), "idle_frame", 0.1), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 0,
				"%s counters %s" % [effect, Terms.ACTIVE_EFFECTS.buffer.name])
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.buffer.name), 2,
				"%s counters %s" % [effect, Terms.ACTIVE_EFFECTS.buffer.name])


class TestDisempower:
	extends "res://tests/HUT_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.disempower.name
	var modified_dmg = int(round(DMG * 0.75))
	func _init() -> void:
		test_card_names = [
			"Interpretation",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": 4,
			}
		]


	func test_disempower_general():
		var sceng = card.execute_scripts()
		assert_eq(test_torment.incoming.get_child_count(), 1,
				"Torment should have 1 intents displayed")
		for prediction in test_torment.incoming.get_children():
			assert_true(prediction.signifier_amount.visible,
					"Damage amount should  be visible")
			assert_eq(prediction.signifier_amount.text, str(modified_dmg),
					"Card damage should be decreased by 25%")
		yield(target_entity(card, test_torment), "completed")
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, starting_torment_dgm + modified_dmg,
				"Torment should decreased damage")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 4,
				effect + " stacks don't reduce on use")

	func test_disempower_end_turn():
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 3,
				"%s stacks should reduce" % [effect])

	func test_disempower_opposite():
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.empower.name, 2,  '')
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 2,
				"%s counters %s" % [effect, Terms.ACTIVE_EFFECTS.empower.name])


class TestPoison:
	extends "res://tests/HUT_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.poison.name
	func _init() -> void:
		torments_amount = 2
		test_card_names = [
			"Interpretation",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": 4,
			}
		]

	func test_poison_general():
		dreamer.defence = 10
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 3,
				"%s stacks decreased by 1" % [effect])
		assert_eq(dreamer.damage, 4,
				"%s did damage through defence" % [effect])

	func test_poison_on_torments():
		spawn_effect(test_torment, effect, 12, '')
		spawn_effect(test_torments[0], effect, 12, '')
		test_torment.health = 10
		test_torment.defence = 10
		test_torments[0].defence = 30
		var intents_to_test = [
			{
				"intent_scripts": ["Stress:6"],
				"reshuffle": true,
			},
		]
		test_torment.intents.replace_intents(intents_to_test)
		test_torment.intents.refresh_intents()
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_true(test_torment.is_dead, "test torment died from %s" % [effect])
		assert_eq(test_torments[0].damage, starting_torment_dgm + 12,
				"%s did damage to torment through defence" % [effect])
		assert_eq(dreamer.damage, 4, "Dreamer not take stress damage because torment died")
		assert_eq(test_torments[0].active_effects.get_effect_stacks(effect), 11,
				"%s stacks decreased by 1" % [effect])

class TestBurn:
	extends "res://tests/HUT_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.burn.name
	func _init() -> void:
		torments_amount = 2
		test_card_names = [
			"Interpretation",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": 14,
			}
		]

	func test_burn_general():
		dreamer.defence = 10
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 13,
				"%s stacks decreased by 1" % [effect])
		assert_eq(dreamer.damage, 4,
				"defence blocked %s" % [effect])

	func test_burn_on_torments():
		spawn_effect(test_torment, effect, 12, '')
		spawn_effect(test_torments[0], effect, 12, '')
		test_torment.health = 10
		var intents_to_test = [
			{
				"intent_scripts": ["Stress:6"],
				"reshuffle": true,
			},
		]
		test_torment.intents.replace_intents(intents_to_test)
		test_torment.intents.refresh_intents()
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_true(test_torment.is_dead, "test torment died from %s" % [effect])
		assert_eq(test_torments[0].damage, starting_torment_dgm + 12,
				"%s did damage to torment through defence" % [effect])
		assert_eq(dreamer.damage, 20, "Dreamer takes stress damage because torment died after intents")
		assert_eq(test_torments[0].active_effects.get_effect_stacks(effect), 11,
				"%s stacks decreased by 1" % [effect])
