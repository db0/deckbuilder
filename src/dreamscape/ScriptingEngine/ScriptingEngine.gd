#class_name DreamscapeScriptingEngine
extends ScriptingEngine

var x_usage: int

# Just calls the parent class.
func _init(state_scripts: Array,
		owner,
		_trigger_object: Node,
		_trigger_details: Dictionary).(state_scripts,
		owner,
		_trigger_object,
		_trigger_details) -> void:
	pass


# Predicts the effects of the action cards on the table.
func predict(_snapshot_id: float) -> void:
	snapshot_id = _snapshot_id
	_predict_script_amount()


# Handles the predictions requested from predict() or _on_potential_target_found()
# Adds prediction icons on all relevant entities.
func _predict_script_amount(hardcoded_previous_subjects := []) -> void:
	run_type = CFInt.RunType.COST_CHECK
	var prev_subjects := hardcoded_previous_subjects
	for task in scripts_queue:
		# We put it into another variable to allow Static Typing benefits
		var script: ScriptTask = task
		# We store the temp modifiers to counters, so that things like
		# info during targetting can take them into account
		cfc.NMAP.board.counters.temp_count_modifiers[self] = {
				"requesting_object": script.owner,
				"modifier": _retrieve_temp_modifiers(script,"counters")
			}
		# This is provisionally stored for games which need to use this
		# information before card subjects have been selected.
		cfc.card_temp_property_modifiers[self] = {
			"requesting_object": script.owner,
			"modifier": _retrieve_temp_modifiers(script, "properties")
		}
		script.subjects = predict_subjects(script, prev_subjects)
		if not script.get_property(SP.KEY_PREDICT_REQUIRES_TARGET)\
				or (script.get_property(SP.KEY_PREDICT_REQUIRES_TARGET)
					and hardcoded_previous_subjects.size() > 0):
			script.prev_subjects = prev_subjects
		#print("Scripting Subjects: " + str(script.subjects)) # Debug
#		if script.script_name == "custom_script": # TODO
#			# This class contains the customly defined scripts for each
#			# card.
#			var custom := CustomScripts.new(costs_dry_run())
#			custom.custom_script(script)
		for entity in script.subjects:
#				entity.temp_properties_modifiers[self] = {
#					"requesting_object": script.owner,
#					"modifier": _retrieve_temp_modifiers(script, "properties")
#				}
			var prediction_method = "calculate_" + script.script_name
			if not script.is_skipped and has_method(prediction_method):
				var amount = call(prediction_method, entity, script)
				if amount is GDScriptFunctionState:
					amount = yield(amount, "completed")
				var prediction_icon = null
				var prediction_type: String
				if script.script_name == "apply_effect":
					prediction_icon = Terms.get_term_value(script.get_property("effect_name"), "icon")
					prediction_type = script.get_property("effect_name")
				elif script.script_name == "assign_defence":
					prediction_icon = Terms.get_term_value("Confidence", "icon")
					prediction_type = "Defence"
				elif script.get_property(SP.KEY_TAGS).has('Exert'):
					prediction_icon = Terms.get_term_value("Anxiety", "icon")
					prediction_type = "Damage"
				entity.show_predictions(amount, prediction_icon, prediction_type)
				var snapshot_method = "snapshot_" + script.script_name
				# We use the "skip_sceng_snapshot" to avoid taking snapshots of predictions for followup scripts
				# Some scripts, like Reckoning Time do not work well with this, because active_effects.get_effect_stacks()
				# (unlike alterants) do not store the sceng snapshot number and the snapshot numbers are cleared
				# only after sceng completes. This is an ugly workaround and a refactoring on the perEngine should
				# fix that.
				if has_method(snapshot_method) and not script.get_property("skip_sceng_snapshot", false):
					call(snapshot_method, script, amount, entity)

		if not script.get_property(SP.KEY_PROTECT_PREVIOUS) and hardcoded_previous_subjects.size() == 0:
			prev_subjects = script.subjects
		if script.get_property(SP.KEY_PREDICT_REQUIRES_TARGET) and hardcoded_previous_subjects.size() == 0:
			script.owner.targeting_arrow.connect("potential_target_found", self, "_on_potential_target_found")
	snapshot_id = 0


func _on_potential_target_found(target) -> void:
#	print_debug(target.get_combat_entity())
	for script in scripts_queue:
		for entity in script.subjects:
			if entity.has_method("clear_predictions"):
				entity.clear_predictions()
	_predict_script_amount([target.get_combat_entity()])


# Will return the adjusted amount of whatever the intent scripts are doing
# if there is one.
func predict_intent_amount(_snapshot_id: float) -> int:
	snapshot_id = _snapshot_id
	run_type = CFInt.RunType.COST_CHECK
	var total_amount := 0
	var prev_subjects := []
	for task in scripts_queue:
		# We put it into another variable to allow Static Typing benefits
		var script: ScriptTask = task
		# This is a failsafe in case the node was deinstanced during testing
		if not cfc.NMAP.has("board"):
			return(0)
		# We store the temp modifiers to counters, so that things like
		# info during targetting can take them into account
		cfc.NMAP.board.counters.temp_count_modifiers[self] = {
				"requesting_object": script.owner,
				"modifier": _retrieve_temp_modifiers(script,"counters")
			}
		# This is provisionally stored for games which need to use this
		# information before card subjects have been selected.
		cfc.card_temp_property_modifiers[self] = {
			"requesting_object": script.owner,
			"modifier": _retrieve_temp_modifiers(script, "properties")
		}
		script.subjects = predict_subjects(script, prev_subjects)
		prev_subjects = script.subjects
		#print("Scripting Subjects: " + str(script.subjects)) # Debug
		if script.script_name == "custom_script": # TODO
			# This class contains the customly defined scripts for each
			# card.
			var custom := CustomScripts.new(costs_dry_run())
			# warning-ignore:narrowing_conversion
			custom.custom_script(script, snapshot_id)
		var prediction_method = "calculate_" + script.script_name
		if script.get_property(SP.KEY_SUBJECT):
			for entity in script.subjects:
	#				entity.temp_properties_modifiers[self] = {
	#					"requesting_object": script.owner,
	#					"modifier": _retrieve_temp_modifiers(script, "properties")
	#				}
				# This checks if the script pretends to be a different type of
				# script, for showing, in the intents
				if not script.is_skipped\
						and script.get_property("predict_as")\
						and script.owner.intents.has_method("calculate_special"):
					var amount = script.owner.intents.calculate_special(self, entity, script)
					if amount is GDScriptFunctionState:
						amount = yield(amount, "completed")
					total_amount += amount
				# This calculates what the numerical results of the intent will be
				# to put in the intent icon.
				elif not script.is_skipped and has_method(prediction_method):
					var amount = call(prediction_method, entity, script)
					if amount is GDScriptFunctionState:
						amount = yield(amount, "completed")
					total_amount += amount
				# If there's multiple targets, we calculate the amount only for a single of them
				break
			var add_to_dreamer_damage_prediction := false
			if script.script_name == "modify_damage" and script.get_property(SP.KEY_SUBJECT) == "dreamer":
				add_to_dreamer_damage_prediction = true
			if script.get_property("add_to_dreamer_damage_prediction", false):
				add_to_dreamer_damage_prediction = true
			if add_to_dreamer_damage_prediction:
				if not cfc.NMAP.board.snapshot_dmg_predictions.has(snapshot_id):
					cfc.NMAP.board.snapshot_dmg_predictions[snapshot_id] = 0
				if not cfc.NMAP.board.snapshot_lost_defence_predictions.has(snapshot_id):
					cfc.NMAP.board.snapshot_lost_defence_predictions[snapshot_id] = 0
				cfc.NMAP.board.snapshot_dmg_predictions[snapshot_id] += total_amount
		else:
			if not script.is_skipped and has_method(prediction_method):
				var amount = call(prediction_method, script)
				if amount is GDScriptFunctionState:
					amount = yield(amount, "completed")
				total_amount += amount

	return(total_amount)


func predict_subjects(script: ScriptTask, prev_subjects: Array) -> Array:
	match script.get_property(SP.KEY_SUBJECT):
		SP.KEY_SUBJECT_V_TARGET, SP.KEY_SUBJECT_V_BOARDSEEK:
			var potential_subjects := []
			for entity in cfc.get_tree().get_nodes_in_group("EnemyEntities"):
				if SP.check_validity(entity, script.script_definition, "subject"):
					potential_subjects.append(entity)
			return(potential_subjects)
		SP.KEY_SUBJECT_V_PREVIOUS:
			var potential_subjects := []
			for entity in prev_subjects:
				if SP.check_validity(entity, script.script_definition, "subject"):
					potential_subjects.append(entity)
			return(potential_subjects)
		SP.KEY_SUBJECT_V_PLAYER:
			if is_instance_valid(cfc.NMAP.board.dreamer) and not cfc.NMAP.board.dreamer.is_dead:
				return([cfc.NMAP.board.dreamer])
			else:
				return([])
		SP.KEY_SUBJECT_V_SELF:
			return([script.owner])
		_:
			return([])


func calculate_modify_damage(subject: CombatEntity, script: ScriptTask) -> int:
	var modification: int
	var card_alteration = 0
	var effect_alteration = 0
	if str(script.get_property(SP.KEY_AMOUNT)) == SP.VALUE_RETRIEVE_INTEGER:
		# If the damage is requested, is only applies to stored integers
		# so we flip the stored_integer's value.
		modification = stored_integer
		if script.get_property(SP.KEY_IS_INVERTED):
			modification *= -1
		modification += script.get_property(SP.KEY_ADJUST_RETRIEVED_INTEGER)
	elif SP.VALUE_PER in str(script.get_property(SP.KEY_AMOUNT)):
		var per_msg = perMessage.new(
				script.get_property(SP.KEY_AMOUNT),
				script.owner,
				script.get_property(script.get_property(SP.KEY_AMOUNT)),
				null,
				script.subjects,
				script.prev_subjects)
		modification = per_msg.found_things
	else:
		modification = script.get_property(SP.KEY_AMOUNT)
	modification = _check_for_x(script, modification)
	card_alteration = _check_for_alterants(script, modification, subject)
	# As the card alterants are always additive, we consider them as part of the value
	# when checking for effects
	effect_alteration = _check_for_effect_alterants(script, modification + card_alteration, subject, self)
	if effect_alteration is GDScriptFunctionState:
		effect_alteration = yield(effect_alteration, "completed")
	var final_amount = modification + card_alteration + effect_alteration
	return(final_amount)


func modify_damage(script_task: ScriptTask) -> int:
	var retcode: int
	var tags: Array = ["Scripted"] + script_task.get_property(SP.KEY_TAGS)
	for combat_entity in script_task.subjects:
		if combat_entity.is_dead:
			continue
		var modification = calculate_modify_damage(combat_entity, script_task)
		# To allow effects like advantage to despawn
		var extra_classification = "Unblocked"
		if combat_entity.blocks_all_damage(modification, tags):
			extra_classification = "Blocked"
		var previous_damage = combat_entity.damage
		var executor = ExecModifyDamage.new(combat_entity, modification, script_task)
		if not costs_dry_run():
			var _anim = IconAnimMessage.new(executor, extra_classification)
			if not executor.has_executed:
				yield(executor, "executed")
			# To allow effects like advantage to despawn
			yield(cfc.get_tree().create_timer(0.05), "timeout")
			retcode = executor.rc
		else:
			retcode = executor.exec(true)
		if script_task.get_property(SP.KEY_STORE_INTEGER):
			stored_integer = combat_entity.damage - previous_damage
	return(retcode)


func calculate_assign_defence(subject: CombatEntity, script: ScriptTask) -> int:
	var modification: int
	var card_alteration = 0
	var effect_alteration = 0
	if str(script.get_property(SP.KEY_AMOUNT)) == SP.VALUE_RETRIEVE_INTEGER:
		# If the modification is requested, is only applies to stored integers
		# so we flip the stored_integer's value.
		modification = stored_integer
		if script.get_property(SP.KEY_IS_INVERTED):
			modification *= -1
		modification += script.get_property(SP.KEY_ADJUST_RETRIEVED_INTEGER)
	elif SP.VALUE_PER in str(script.get_property(SP.KEY_AMOUNT)):
		var per_msg = perMessage.new(
				script.get_property(SP.KEY_AMOUNT),
				script.owner,
				script.get_property(script.get_property(SP.KEY_AMOUNT)),
				null,
				script.subjects,
				script.prev_subjects)
		modification = per_msg.found_things
	else:
		modification = script.get_property(SP.KEY_AMOUNT)
	modification = _check_for_x(script, modification)
	card_alteration = _check_for_alterants(script, modification, subject)
	# As the card alterants are always additive, we consider them as part of the value
	# when checking for effects
	effect_alteration = _check_for_effect_alterants(script, modification + card_alteration, subject, self)
	if effect_alteration is GDScriptFunctionState:
		effect_alteration = yield(effect_alteration, "completed")
	var final_amount = modification + card_alteration + effect_alteration
	return(final_amount)

func assign_defence(script_task: ScriptTask) -> int:
	var retcode: int
	var set_to_mod: bool = script_task.get_property(SP.KEY_SET_TO_MOD)
	for combat_entity in script_task.subjects:
		if combat_entity.is_dead:
			continue
		var defence = calculate_assign_defence(combat_entity, script_task)
		var previous_defence = combat_entity.defence
		var executor = ExecAssignDefence.new(combat_entity, defence, set_to_mod, script_task)
		if not costs_dry_run():
			var _anim = IconAnimMessage.new(executor)
			if not executor.has_executed:
				yield(executor, "executed")
			retcode = executor.rc
		else:
			retcode = executor.exec(true)
		if script_task.get_property(SP.KEY_STORE_INTEGER):
			stored_integer = combat_entity.defence - previous_defence
	return(retcode)


func calculate_apply_effect(subject: CombatEntity, script: ScriptTask) -> int:
	var modification: int
	var card_alteration = 0
	var effect_alteration = 0
	var set_to_mod: bool = script.get_property(SP.KEY_SET_TO_MOD)
	if str(script.get_property(SP.KEY_MODIFICATION)) == SP.VALUE_RETRIEVE_INTEGER:
		modification = stored_integer
		if script.get_property(SP.KEY_IS_INVERTED):
			modification *= -1
		modification += script.get_property(SP.KEY_ADJUST_RETRIEVED_INTEGER)
	elif SP.VALUE_PER in str(script.get_property(SP.KEY_MODIFICATION)):
		var per_msg = perMessage.new(
				script.get_property(SP.KEY_MODIFICATION),
				script.owner,
				script.get_property(script.get_property(SP.KEY_MODIFICATION)),
				null,
				script.subjects,
				script.prev_subjects)
		modification = per_msg.found_things
#		print_debug(per_msg.found_things, modification)
	else:
		modification = script.get_property(SP.KEY_MODIFICATION)
	modification = _check_for_x(script, modification)
	if not set_to_mod:
		card_alteration = _check_for_alterants(script, modification, subject)
		# As the card alterants are always additive, we consider them as part of the value
		# when checking for effects
		effect_alteration = _check_for_effect_alterants(script, modification + card_alteration, subject, self)
		if effect_alteration is GDScriptFunctionState:
			effect_alteration = yield(effect_alteration, "completed")
	var final_amount = modification + card_alteration + effect_alteration
	return(final_amount)


func apply_effect(script_task: ScriptTask) -> int:
	var retcode: int
	var effect_name: String = script_task.get_property(SP.KEY_EFFECT)
	var upgrade_name: String = script_task.get_property(SP.KEY_UPGRADE_NAME, '')
	# We inject the tags from the script into the tags sent by the signal
	var set_to_mod: bool = script_task.get_property(SP.KEY_SET_TO_MOD)
	var stacks_diff := 0
	for e in script_task.subjects:
		var combat_entity: CombatEntity = e
		if combat_entity.is_dead:
			continue
		var final_amount = calculate_apply_effect(combat_entity, script_task)
		var current_stacks: int
		# If we're storing the integer, we want to store the difference
		# cumulative difference between the current and modified effect stacks
		# among all the tasrgets
		# If we set set stacks to 1, and one entity had 3 stacks,
		# while another had 0
		# The total stored integer would be -1
		# This allows us to do an effect like
		# Remove all Poison stacks from all entities, gain 1 health for each stack removed.
		if script_task.get_property(SP.KEY_STORE_INTEGER):
			current_stacks = combat_entity.active_effects.get_effect_stacks(effect_name)
			if set_to_mod:
				stacks_diff += final_amount - current_stacks
			elif current_stacks + final_amount < 0:
				stacks_diff += -current_stacks
			else:
				stacks_diff = final_amount
		var executor = ExecApplyEffect.new(
				combat_entity,
				effect_name,
				final_amount,
				set_to_mod,
				upgrade_name,
				script_task)
		if not costs_dry_run():
			var _anim = IconAnimMessage.new(executor)
			if not executor.has_executed:
				yield(executor, "executed")
			retcode = executor.rc
		else:
			retcode = executor.exec(true)
	if script_task.get_property(SP.KEY_STORE_INTEGER):
		stored_integer = stacks_diff
	return(retcode)

func snapshot_apply_effect(script: ScriptTask, final_amount: int, entity: CombatEntity):
	var effect_name: String = script.get_property(SP.KEY_EFFECT)
	var upgrade_name: String = script.get_property(SP.KEY_UPGRADE_NAME, '')
	# We inject the tags from the script into the tags sent by the signal
	var tags: Array = ["Scripted"] + script.get_property(SP.KEY_TAGS)
	var set_to_mod: bool = script.get_property(SP.KEY_SET_TO_MOD)
	entity.active_effects.snapshot_effect(
			effect_name,
			final_amount,
			set_to_mod,
			tags,
			upgrade_name)


func remove_card_from_deck(script: ScriptTask) -> int:
	var retcode: int = CFConst.ReturnCode.CHANGED
	if not costs_dry_run():
		# We inject the tags from the script into the tags sent by the signal
		var tags: Array = ["Scripted"] + script.get_property(SP.KEY_TAGS)
		var is_permanent: bool = script.get_property(SP.KEY_PERMANENT, true)
		for card in script.subjects:
			card.remove_from_deck(is_permanent, tags)
			# We do not want to have a removed instance in previous subjects
			script.subjects.erase(card)
	return(retcode)


func autoplay_card(script: ScriptTask) -> int:
	var retcode : int = CFConst.ReturnCode.CHANGED
	# If your subject is "self" make sure you know what you're doing
	# or you might end up in an inifinite loop
	var tags: Array = ["Scripted"] + script.get_property(SP.KEY_TAGS)
	for card in script.subjects:
		if not costs_dry_run():
			# We store this to send it later with a signal
			var prev_pos = card.global_position
			card.get_parent().remove_child(card)
			cfc.NMAP.board.add_child(card)
			card.set_is_faceup(true)
			# We first move it to the center of the view and hold it there
			# for a few seconds, for the player to see the card being played.
			card.state = card.ExtendedCardState.AUTOPLAY_DISPLAY
			card._add_tween_global_position(
					prev_pos,
					cfc.get_viewport().size / 2 - CFConst.CARD_SIZE/2,
					1,
					Tween.TRANS_SINE,
					Tween.EASE_IN_OUT)
			card.z_index = 0
			card._add_tween_rotation(0,360, 1)
			card._tween.start()
			yield(card._tween, "tween_all_completed")
			yield(card.get_tree().create_timer(1), "timeout")
			var card_scripts = card.retrieve_scripts("manual")
			var autoplay_exec : String = card.get_state_exec()
			if not card_scripts.get("hand"):
				if card.get_property("Type") == "Concentration" or card.get_property("_is_concentration"):
					card_scripts[autoplay_exec] = card.generate_remove_from_deck_tasks(false, tags)
				else:
					card_scripts[autoplay_exec] = card.generate_discard_tasks("board", tags)
			else:
				# We want to autoselect multiple choice cards, because cancelling them
				# Will leave card on the table
				if typeof(card_scripts[autoplay_exec]) == TYPE_DICTIONARY:
					var option_keys = card_scripts[autoplay_exec].keys()
					CFUtils.shuffle_array(option_keys)
					card_scripts[autoplay_exec] = card_scripts[autoplay_exec][option_keys[0]]
				card_scripts[autoplay_exec] = card_scripts["hand"]
				if card.get_property("Type") == "Concentration" or card.get_property("_is_concentration"):
					card_scripts[autoplay_exec] += card.generate_remove_from_deck_tasks(false, tags)
				else:
					card_scripts[autoplay_exec] += card.generate_discard_tasks("board", tags)
				card_scripts[autoplay_exec] += card.generate_play_confirm_scripts()
				_adjust_autoplay_tasks(card_scripts[autoplay_exec])
			card.scripts["autoplay"] = card_scripts
			var sceng = card.execute_scripts(
					script.owner,
					"autoplay",
					{}, costs_dry_run())
			# We make sure we wait until the execution is finished
			# before cleaning out the temp properties/counters
			if sceng is GDScriptFunctionState:
				sceng = yield(sceng, "completed")
			# If the card had a clause which prevents from being played (such as Utterly Ridiculous)
			# We still want to discard it
			if card.state == card.ExtendedCardState.AUTOPLAY_DISPLAY:
				card.move_to(cfc.NMAP.discard, -1, null, ["scripted"])
	return(retcode)


func perturb(script: ScriptTask) -> void:
	var card: Card
	var count: int
	var alteration = 0
	var canonical_name: String = script.get_property(SP.KEY_CARD_NAME)
	var dest_container: CardContainer = cfc.NMAP[script.get_property(SP.KEY_DEST_CONTAINER).to_lower()]
	if str(script.get_property(SP.KEY_OBJECT_COUNT)) == SP.VALUE_RETRIEVE_INTEGER:
		count = stored_integer
		if script.get_property(SP.KEY_IS_INVERTED):
			count *= -1
		count += script.get_property(SP.KEY_ADJUST_RETRIEVED_INTEGER)
	elif SP.VALUE_PER in str(script.get_property(SP.KEY_OBJECT_COUNT)):
		var per_msg = perMessage.new(
				script.get_property(SP.KEY_OBJECT_COUNT),
				script.owner,
				script.get_property(script.get_property(SP.KEY_OBJECT_COUNT)),
				null,
				script.subjects,
				script.prev_subjects)
		count = per_msg.found_things
	else:
		count = script.get_property(SP.KEY_OBJECT_COUNT)
	alteration = _check_for_alterants(script, count)
	if alteration is GDScriptFunctionState:
		alteration = yield(alteration, "completed")
	for iter in range(count + alteration):
		card = cfc.instance_card(canonical_name)
		cfc.NMAP.board.add_child(card)
		card.scale = Vector2(0.1,0.1)
		if 'rect_global_position' in script.owner:
			card.global_position = script.owner.rect_global_position
		else:
			card.global_position = script.owner.global_position
		card.global_position.x += \
				iter * CFConst.CARD_SIZE.x * 0.2
		card.pertub_destination = dest_container
		card.state = DreamCard.ExtendedCardState.SPAWNED_PERTURBATION
		if script.get_property(SP.KEY_IS_PERMANENT):
			# warning-ignore:return_value_discarded
			globals.player.deck.add_new_card(canonical_name)
		yield(cfc.get_tree().create_timer(0.2), "timeout")


func spawn_enemy(script: ScriptTask) -> void:
	var count: int
	var alteration = 0
	var enemy_properties: Dictionary = script.get_property(SP.KEY_ENEMY)
	if str(script.get_property(SP.KEY_OBJECT_COUNT)) == SP.VALUE_RETRIEVE_INTEGER:
		count = stored_integer
		if script.get_property(SP.KEY_IS_INVERTED):
			count *= -1
		count += script.get_property(SP.KEY_ADJUST_RETRIEVED_INTEGER)
	elif SP.VALUE_PER in str(script.get_property(SP.KEY_OBJECT_COUNT)):
		var per_msg = perMessage.new(
				script.get_property(SP.KEY_OBJECT_COUNT),
				script.owner,
				script.get_property(script.get_property(SP.KEY_OBJECT_COUNT)),
				null,
				script.subjects,
				script.prev_subjects)
		count = per_msg.found_things
	else:
		count = script.get_property(SP.KEY_OBJECT_COUNT)
	alteration = _check_for_alterants(script, count)
	if alteration is GDScriptFunctionState:
		alteration = yield(alteration, "completed")
	for _iter in range(count + alteration):
		var enemy_entity : EnemyEntity = cfc.NMAP.board.spawn_enemy(enemy_properties)
		yield(cfc.get_tree().create_timer(0.05), "timeout")
		# We need to set it as activated or the board will never re-enable the
		# end-turn button
		if enemy_entity:
			var health_modify: int = script.get_property(SP.KEY_MODIFY_SPAWN_HEALTH, 0)
			if enemy_entity.health + health_modify <= 0:
				enemy_entity.health = 1
			else:
				enemy_entity.health += health_modify
			var spawn_as_minion :bool = script.get_property(SP.KEY_SET_SPAWN_AS_MINION, false)
			if spawn_as_minion:
				enemy_entity.add_to_group("MinionEnemyEntities")
			else:
				enemy_entity.add_to_group("BasicEnemyEntities")
			enemy_entity.emit_signal("finished_activation", enemy_entity)
			var stating_intent = script.get_property('starting_intent', null)
			if stating_intent:
				# This delay is needed to allow the starting intent to be added
				# so that it can be seen to be queued_free
				yield(cfc.get_tree().create_timer(0.01), "timeout")
				# warning-ignore:return_value_discarded
				enemy_entity.intents.prepare_intents(stating_intent)
			var stating_effects = script.get_property('starting_effects', null)
			if stating_effects:
				for effect in stating_effects:
					enemy_entity.active_effects.mod_effect(
							effect["name"],
							effect["stacks"],
							false,
							false,
							['Init'],
							effect.get("upgrade", ''))
			if script.get_property('rebalancing', null):
				enemy_entity.intents.rebalancing = script.get_property('rebalancing', {})

func draw_cards(script: ScriptTask) -> int:
	var retcode: int = CFConst.ReturnCode.CHANGED
	if not costs_dry_run():
		# We inject the tags from the script into the tags sent by the signal
		var _tags: Array = ["Scripted"] + script.get_property(SP.KEY_TAGS)
		var card_count: int
		if str(script.get_property(SP.KEY_CARD_COUNT)) == SP.VALUE_RETRIEVE_INTEGER:
			card_count = stored_integer
			if script.get_property(SP.KEY_IS_INVERTED):
				card_count *= -1
			card_count += script.get_property(SP.KEY_ADJUST_RETRIEVED_INTEGER)
		else:
			card_count = script.get_property(SP.KEY_CARD_COUNT)
		var drawn_cards := []
		for _iter in range(card_count):
			var dcard = cfc.NMAP.hand.draw_card(cfc.NMAP.deck)
			if dcard is GDScriptFunctionState:
				dcard = yield(dcard, "completed")
			drawn_cards.append(dcard)
			yield(cfc.get_tree().create_timer(0.05), "timeout")
		# We set the drawn cards as the subjects, so that they can be
		# used by other followup scripts
		script.subjects = drawn_cards
	return(retcode)


func set_discount(script: ScriptTask) -> int:
	var retcode: int = CFConst.ReturnCode.CHANGED
	if not costs_dry_run():
		# We inject the tags from the script into the tags sent by the signal
		var _tags: Array = ["Scripted"] + script.get_property(SP.KEY_TAGS)
		var discount_amount: int
		if str(script.get_property(SP.KEY_DISCOUNT_AMOUNT)) == SP.VALUE_RETRIEVE_INTEGER:
			discount_amount = stored_integer
			if script.get_property(SP.KEY_IS_INVERTED):
				discount_amount *= -1
			discount_amount += script.get_property(SP.KEY_ADJUST_RETRIEVED_INTEGER)
		else:
			discount_amount = script.get_property(SP.KEY_DISCOUNT_AMOUNT, 1)
			if script.get_property(SP.KEY_IS_INVERTED):
				discount_amount *= -1
		var discount_filters := []
		for filter_def in script.get_property(SP.KEY_DISCOUNT_FILTERS, []):
			var new_filter = CardFilter.new(
				filter_def.property,
				filter_def.value,
				filter_def.get("comparison", 'eq'),
				filter_def.get("_compare_int_as_str", false),
				filter_def.get("custom_filter", null)
			)
			discount_filters.append(new_filter)
		var discount_uses : int = script.get_property("discount_uses", 1)
		var counter : String = script.get_property(SP.KEY_COUNTER_NAME, "Immersion")
		var is_permanent : bool = script.get_property("is_permanent", false)
		var discount = CostDiscount.new(
				discount_amount,
				discount_uses,
				discount_filters,
				counter,
				is_permanent)
		cfc.NMAP.board.counters.add_child(discount)
	return(retcode)


func enable_rider(script: ScriptTask) -> int:
	var retcode: int = CFConst.ReturnCode.CHANGED
	if not costs_dry_run():
		# We inject the tags from the script into the tags sent by the signal
		var _tags: Array = ["Scripted"] + script.get_property(SP.KEY_TAGS)
		var rider: String = script.get_property(SP.RIDER)
		for card in script.subjects:
			card.enable_rider(rider)
	return(retcode)


# Executes custom definitions in the enemy intents script.
# Typically used in Bosses and Elites for specialized effects.
func torment_special(script: ScriptTask) -> int:
	var retcode = script.owner.intents.execute_special(script, costs_dry_run())
	if retcode is GDScriptFunctionState:
		retcode = yield(retcode, "completed")
	return(retcode)


func calculate_modify_pathos(script: ScriptTask) -> float:
	var modification: float
	var alteration = 0
	if str(script.get_property(SP.KEY_AMOUNT)) == SP.VALUE_RETRIEVE_INTEGER:
		# If the modification is requested, is only applies to stored integers
		# so we flip the stored_integer's value.
		modification = stored_integer
		if script.get_property(SP.KEY_IS_INVERTED):
			modification *= -1
		modification += script.get_property(SP.KEY_ADJUST_RETRIEVED_INTEGER)
	elif SP.VALUE_PER in str(script.get_property(SP.KEY_AMOUNT)):
		var per_msg = perMessage.new(
				script.get_property(SP.KEY_AMOUNT),
				script.owner,
				script.get_property(script.get_property(SP.KEY_AMOUNT)),
				null,
				script.subjects,
				script.prev_subjects)
		modification = per_msg.found_things
	else:
		modification = script.get_property(SP.KEY_AMOUNT, 0.0)
	# warning-ignore:narrowing_conversion
	modification = _check_for_x(script, modification)
	# warning-ignore:narrowing_conversion
	alteration = _check_for_effect_alterants(script, modification, cfc.NMAP.board.dreamer, self)
	if alteration is GDScriptFunctionState:
		alteration = yield(alteration, "completed")
	var final_result = modification + alteration
	return(final_result)


func modify_pathos(script_task: ScriptTask) -> int:
	var retcode: int
	var type = script_task.get_property("pathos_type", "temp")
	var is_convertion = script_task.get_property("is_convertion", false)
	var pathos = script_task.get_property("pathos", Terms.RUN_ACCUMULATION_NAMES.enemy)
	var modification = calculate_modify_pathos(script_task)
	var executor = ExecModifyPathos.new(
			pathos,
			modification,
			is_convertion,
			type,
			script_task)
	if not costs_dry_run():
		var _anim = IconAnimMessage.new(executor, '', true)
		if not executor.has_executed:
			yield(executor, "executed")
		retcode = executor.rc
	else:
		retcode = executor.exec(true)
	return(retcode)

func calculate_modify_masteries(script: ScriptTask) -> float:
	var modification: float
	var alteration = 0
	if str(script.get_property(SP.KEY_AMOUNT)) == SP.VALUE_RETRIEVE_INTEGER:
		# If the modification is requested, is only applies to stored integers
		# so we flip the stored_integer's value.
		modification = stored_integer
		if script.get_property(SP.KEY_IS_INVERTED):
			modification *= -1
		modification += script.get_property(SP.KEY_ADJUST_RETRIEVED_INTEGER)
	elif SP.VALUE_PER in str(script.get_property(SP.KEY_AMOUNT)):
		var per_msg = perMessage.new(
				script.get_property(SP.KEY_AMOUNT),
				script.owner,
				script.get_property(script.get_property(SP.KEY_AMOUNT)),
				null,
				script.subjects,
				script.prev_subjects)
		modification = per_msg.found_things
	else:
		modification = script.get_property(SP.KEY_AMOUNT, 0)
	# warning-ignore:narrowing_conversion
	modification = _check_for_x(script, modification)
	# warning-ignore:narrowing_conversion
	alteration = _check_for_effect_alterants(script, modification, cfc.NMAP.board.dreamer, self)
	if alteration is GDScriptFunctionState:
		alteration = yield(alteration, "completed")
	var final_result = modification + alteration
	return(final_result)


func modify_masteries(script_task: ScriptTask) -> int:
	var retcode: int
	var modification = calculate_modify_masteries(script_task)
	var executor = ExecModifyMasteries.new(
			modification,
			script_task)
	if not costs_dry_run():
		var _anim = IconAnimMessage.new(executor, '', true)
		if not executor.has_executed:
			yield(executor, "executed")
		retcode = executor.rc
	else:
		retcode = executor.exec(true)
	return(retcode)


func calculate_modify_health(subject: CombatEntity, script: ScriptTask) -> int:
	var modification: int
	var alteration = 0
	if str(script.get_property(SP.KEY_AMOUNT)) == SP.VALUE_RETRIEVE_INTEGER:
		# If the damage is requested, is only applies to stored integers
		# so we flip the stored_integer's value.
		modification = stored_integer
		if script.get_property(SP.KEY_IS_INVERTED):
			modification *= -1
		modification += script.get_property(SP.KEY_ADJUST_RETRIEVED_INTEGER)
	elif SP.VALUE_PER in str(script.get_property(SP.KEY_AMOUNT)):
		var per_msg = perMessage.new(
				script.get_property(SP.KEY_AMOUNT),
				script.owner,
				script.get_property(script.get_property(SP.KEY_AMOUNT)),
				null,
				script.subjects,
				script.prev_subjects)
		modification = per_msg.found_things
	else:
		modification = script.get_property(SP.KEY_AMOUNT)
	modification = _check_for_x(script, modification)
	alteration = _check_for_effect_alterants(script, modification, subject, self)
	if alteration is GDScriptFunctionState:
		alteration = yield(alteration, "completed")
	var final_result = modification + alteration
	return(final_result)


func modify_health(script_task: ScriptTask) -> int:
	var retcode: int
	var set_to_mod = script_task.get_property(SP.KEY_SET_TO_MOD)
	for combat_entity in script_task.subjects:
		if combat_entity.is_dead:
			continue
		var modification = calculate_modify_health(combat_entity, script_task)
		var executor = ExecModifyHealth.new(combat_entity, modification, set_to_mod, script_task)
		if not costs_dry_run():
			var _anim = IconAnimMessage.new(executor)
			if not executor.has_executed:
				yield(executor, "executed")
			retcode = executor.rc
		else:
			retcode = executor.exec(true)
	return(retcode)

# Used to perform some post-play activities, once all the script costs
# have been paid.
func confirm_play(script: ScriptTask) -> int:
	var retcode: int = CFConst.ReturnCode.CHANGED
	if not costs_dry_run():
		if not cfc.NMAP.board.dreamer.active_effects.get_effect_stacks("Creative Block"):
			if script.owner.deck_card_entry and script.owner.deck_card_entry.record_use():
				cfc.NMAP.board.dreamer.upgrades_increased += 1
		# warning-ignore:return_value_discarded
		TurnEventMessage.new("cards_played", +1)
		# warning-ignore:return_value_discarded
		TurnRecordCardPlayMessage.new(script.owner.canonical_name)
		var card_type_event = script.owner.get_property("Type") + "_played"
		# warning-ignore:return_value_discarded
		TurnEventMessage.new(card_type_event, +1)
		for tag in script.owner.get_property("Tags"):
			# warning-ignore:return_value_discarded
			TurnEventMessage.new(tag, +1)
	return(retcode)


func end_turn(_script_task: ScriptTask) -> int:
	var retcode: int = CFConst.ReturnCode.CHANGED
	if not costs_dry_run():
		cfc.NMAP.board.turn.end_player_turn()
	return(retcode)


# Task for modifying a card's amounts
# * Requires the following keys:
#	* [KEY_SUBJECT](ScriptProperties#KEY_SUBJECT)
#	* [KEY_AMOUNT_KEY](SP#KEY_AMOUNT_KEY)
#	* [KEY_AMOUNT_VALUE](SP#KEY_AMOUNT_VALUE)
# * Optionall specify also
#   * [KEY_AMOUNT_PURPOSE](SP#KEY_AMOUNT_PURPOSE)
func modify_amount(script: ScriptTask) -> int:
	var retcode: int = CFConst.ReturnCode.CHANGED
	for card in script.subjects:
		var amount_key = script.get_property(SP.KEY_AMOUNT_KEY)
		var value = script.get_property(SP.KEY_AMOUNT_VALUE)
		var purpose = script.get_property(SP.KEY_AMOUNT_PURPOSE, '')
		HUtils.modify_amounts(card.properties, amount_key, value, purpose)
		card.refresh_card_front()
	return(retcode)

func mod_counter(script_task: ScriptTask) -> int:
	if not "PlayCost" in script_task.get_property(SP.KEY_TAGS) and not costs_dry_run():
		var executor = ExecModCounter.new('', 0, script_task)
		if not costs_dry_run():
			var _anim = IconAnimMessage.new(executor, '', true)
	return(.mod_counter(script_task))
	
# Initiates a seek through the owner and target combat entity to see if there's any effects
# which modify the intensity of the task in question
static func _check_for_effect_alterants(
		script: ScriptTask,
		value: int,
		subject: CombatEntity,
		sceng) -> int:
	var alteration_details = {}
	var source_object: CombatEntity
	var new_value := value
	if script.owner.get_class() == "Card":
		source_object = cfc.NMAP.board.dreamer
	elif "combat_entity" in script.owner:
		source_object = script.owner.combat_entity
	else:
		source_object = script.owner
	var organized_effects := {
		"adders" : [],
		"multipliers" : [],
		"setters" : [],
	}
	# We grab the full list of source and subject items, in order to specify
	# correctly to the alterants which is which.
	# E.g. we don't want effects which decrease damage when attacked, to decrease
	# damage when we're attacking someone else.
	var source_effects : Array = source_object.active_effects.get_all_effects().values()
	# warning-ignore:unused_variable
	var subject_effects : Array = subject.active_effects.get_all_effects().values()
	var artifacts : Array = cfc.NMAP.board.player_info.get_all_artifacts().values()
	# We grab the ordered dictionary for each type of effect. Source, Subject and Artifact
	# We will organize the alterants so that adders are first, then multipliers, the setters.
	# This way we allow an effect which multiplies the attack, to take into account additions first.
	organized_effects = source_object.active_effects.get_ordered_effects(organized_effects)
	organized_effects = subject.active_effects.get_ordered_effects(organized_effects)
	organized_effects = cfc.NMAP.board.player_info.get_ordered_artifacts(organized_effects)
	var ordered_effects = organized_effects.adders + organized_effects.multipliers + organized_effects.setters
	for effect in ordered_effects:
		var is_source := false
		if effect in source_effects:
			is_source = true
		# The artifacts consider themselves to be the source of the alteration
		# only if the effect is triggered by the dreamer or their cards.
		if effect in artifacts and source_object == cfc.NMAP.board.dreamer:
			is_source = true
		var alteration : int = effect.get_effect_alteration(
				script,
				new_value,
				sceng,
				is_source,
				sceng.costs_dry_run(),
				subject)
		alteration_details[effect] = alteration
		new_value += alteration
	return(new_value - value)


# X is a result in the scripts that is based on how much immersion the player has
# at the moment of playing the card
func _get_x(x_modifier) -> int:
	var x : int = x_usage
	if x_modifier:
		# If the modifier is 0. then X is exactly the amount of immersion the player has
		# If the modifier is +/- then X is the number of immersion the the player has +/- this modifier
		if x_modifier.is_valid_integer():
			x += int(x_modifier)
		# If the modifier has a '*', X is the number of immersion the the player multiplied by this modifier.
		elif '*' in x_modifier:
			x += int(x_modifier.lstrip('*'))
		# If the modifier has a '/', X is the number of immersion the the player divided by this modifier.
		elif '/' in x_modifier:
			x += int(x_modifier.lstrip('/'))
	return(x)


func _check_for_x(script: ScriptTask, final_amount: int) -> int:
	var x_operation = script.get_property(SP.KEY_X_OPERATION)
	if x_operation:
		var x_modifier = _get_x(script.get_property(SP.KEY_X_MODIFIER))
		if x_operation == 'add':
			return(final_amount + x_modifier)
		else:
			return(final_amount * x_modifier)
	# If no "x_operation" property has been defined on the script, we
	# can just return the usual results
	else:
		return(final_amount)


# Extendable function to perform extra checks on the script
# according to game logic
func _pre_task_exec(script: ScriptTask) -> void:
	if not is_instance_valid(script.owner):
		script.is_valid = false
		return
	if script.owner is CombatEntity and script.owner.is_dead:
		script.is_valid = false


func _adjust_autoplay_tasks(card_tasks: Array) -> void:
	for script_task in card_tasks:
		if script_task.get("subject") and script_task["subject"] == 'target':
			script_task["subject"] = "boardseek"
			script_task["subject_count"] = 1
			script_task["sort_by"] = "random"
			if script_task.get("filter_state_subject"):
				script_task["filter_state_seek"] = script_task.get("filter_state_subject")
		script_task["is_cost"] = false
		script_task["needs_subject"] = false
		if script_task["name"] == "nested_script":
			_adjust_autoplay_tasks(script_task["nested_tasks"])
