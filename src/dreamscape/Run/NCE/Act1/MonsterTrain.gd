extends NonCombatEncounter

var artifact_prep : ArtifactPrep

var secondary_choices := {
		'lead': '[Lead]: Take 15 anxiety. 60% chance to gain a random curio.',
		'follow': '[Follow]: Take 7 anxiety. Gain {follow_amount} released {shop}.',
		'abort': '[Abort]: Gain {abort_amount} repressed {elite}.',
	}

var nce_result_fluff := {
		'lead': "I am this train's leader. The monsters all look up to me. "\
			+ "I want to see what lies at the center of hell!",
		'follow': "I realized I am just one of the monsters myself, and I did "\
			+ "my duty among others, to see the train through.",
		'abort': "I am not meant to be here, but I can't shake the feeling "\
			+ "that not helping out will come to haunt me later...",
	}


func _init():
	description = "I seemed to be surrounded by monsters but for some reason, they were friendly to me. "\
			+ "I realized I am in a train and am prepared to drive "\
			+ "through the forces of Order to revive the Heart of Hell itself!\n"\
			+ "Did I lead, or did I follow?"
	prepare_journal_art(preload("res://assets/journal/nce/monster_train.jpeg"))

func begin() -> void:
	# warning-ignore:return_value_discarded
	.begin()
	var scformat := Terms.RUN_ACCUMULATION_NAMES.duplicate()
	scformat["follow_amount"] = globals.player.pathos.get_progression_average(
			Terms.RUN_ACCUMULATION_NAMES.shop) * 3
	scformat["abort_amount"] = globals.player.pathos.get_progression_average(
			Terms.RUN_ACCUMULATION_NAMES.elite) * 2
	for key in secondary_choices:
		secondary_choices[key] = secondary_choices[key].format(scformat).format(Terms.get_bbcode_formats(18))
	globals.journal.add_nested_choices(secondary_choices)

func continue_encounter(key) -> void:
	match key:
		"lead":
			globals.player.damage += 15
			var artifact_roll = CFUtils.randi_range(1,100)
			if artifact_roll <= 60:
				artifact_prep = ArtifactPrep.new(5, 20, 1)
				nce_result_fluff['lead'] += "\nThrough your leadership, this train of monsters succeeds "\
						+ "in reaching the heart of hell, {curio}:"
				var fmt = {"curio": _prepare_artifact_popup_bbcode(artifact_prep.selected_artifacts[0].canonical_name, "and you take it as your own reward")}
				nce_result_fluff['lead'] = nce_result_fluff['lead'].format(fmt)
				globals.player.add_artifact(artifact_prep.selected_artifacts[0].canonical_name)
			else:
				nce_result_fluff['lead'] += "\nYou try to lead this train, but you quickly realize you're out of your depth. "\
						+ "The forces of Order soon overwhelmed your band."
		"follow":
			globals.player.damage += 7
			# warning-ignore:narrowing_conversion
			globals.player.pathos.modify_released_pathos(
				Terms.RUN_ACCUMULATION_NAMES.shop,
				globals.player.pathos.get_progression_average(
					Terms.RUN_ACCUMULATION_NAMES.shop) * 3)
		"abort":
			# warning-ignore:narrowing_conversion
			globals.player.pathos.repress_pathos(
					Terms.RUN_ACCUMULATION_NAMES.elite,
					globals.player.pathos.get_progression_average(
						Terms.RUN_ACCUMULATION_NAMES.elite) * 2)
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])
