# Don't know why, but putting a class name here, breaks HTML exports
#class_name CoreScripts
extends Reference

# If the upgraded card name is prepending one of these words
# Then we know it's going to be using the same script definition as the original
# card.
# This allows us to avoid writing new definitions when all that is changing
# is the card statistics (like cost)
const SAME_SCRIPT_MODIFIERS := [
	"Easy", # Used when the upgraded card has just lower cost
	"Solid", # Used when the upgraded card has higher amount or damage or defence.
	"Enhanced", # Used when the upgraded card has higher amount of effect stacks.
	"Ephemeral", # Used when the upgraded card is adding an extra task to remove the card from deck.
	"Fleeting", # Used when the upgraded card is adding an extra task to exhaust the card.
]

# When a the "Ephemeral" prepend has been added to a card upgrade
# It means the card is permanently removed from the deck after using it.
# This is the ScEng task that does this, and it is automatically appended
# to the card's normal scripts.
# For this to work properly, the card definition needs to also have
# The "_avoid_normal_discard" property set to true
const EPHEMERAL_TASK := {
	"name": "remove_card_from_deck",
	"subject": "self",
}

# This fuction returns all the scripts of the specified card name.
#
# if no scripts have been defined, an empty dictionary is returned instead.
func get_scripts(card_name: String) -> Dictionary:
	var scripts := {
		"Interpretation": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("damage_amount"),
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
				],
			},
		},
		"Confidence": {
			"manual": {
				"hand": [
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("defence_amount"),
					}
				],
			},
		},
		"Noisy Whip": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 5,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
						"subject": "previous",
						"modification": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("effect_stacks"),
					}
				],
			},
		},
		"Dive-in": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
						"subject": "dreamer",
						"modification": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("effect_stacks"),
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.advantage.name,
						"subject": "dreamer",
						"modification": 1,
					}
				],
			},
		},
		"Powerful Dive-in": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
						"subject": "dreamer",
						"modification": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("effect_stacks"),
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.advantage.name,
						"subject": "dreamer",
						"modification": 1,
						"upgrade_name": "powerful",
					}
				],
			},
		},
		"Safety of Air": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "dreamer",
						"amount": -cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("healing_amount", 0),
						"tags": ["Healing"],
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": cfc.NMAP.forgotten,
					},
				],
			},
		},
		"Sustained Safety of Air": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "dreamer",
						"amount": -cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("healing_amount", 0),
						"tags": ["Healing"],
					},
				],
			},
		},
		"Nothing to Fear": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.nothing_to_fear.name,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Tough Nothing to Fear": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.nothing_to_fear.name,
						"subject": "dreamer",
						"modification": 1,
						"upgrade_name": "tough",
					},
				],
			},
		},
		"Out of Reach": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.impervious.name,
						"subject": "dreamer",
						"modification": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("effect_stacks"),
					},
				],
			},
		},
		"Confounding Movements": {
			"manual": {
				"hand": [
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("defence_amount"),
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
						"subject": "target",
						"is_cost": true,
						"modification": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("effect_stacks"),
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					}
				],
			},
		},
		"Inner Justice": {
			"manual": {
				"hand": [
					{
						"name": "mod_counter",
						"counter_name": "immersion",
						"modification": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("immersion_amount"),
					},
				],
			},
		},
		"Whirlwind": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("damage_amount"),
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "modify_damage",
						"subject": "previous",
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("damage_amount"),
						"tags": ["Attack"],
					},
					{
						"name": "modify_damage",
						"subject": "previous",
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("damage_amount"),
						"tags": ["Attack"],
					},
				],
			},
		},
		"Wild Whirlwind": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("damage_amount"),
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "modify_damage",
						"subject": "previous",
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("damage_amount"),
						"tags": ["Attack"],
					},
					{
						"name": "modify_damage",
						"subject": "previous",
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("damage_amount"),
						"tags": ["Attack"],
					},
					{
						"name": "modify_damage",
						"subject": "previous",
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("damage_amount"),
						"tags": ["Attack"],
					},
				],
			},
		},
		"Overview": {
			"manual": {
				"hand": [
					{
						"name": "assign_defence",
						"subject": "target",
						"amount": 0,
						"set_to_mod": true,
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
				],
			},
		},
		"Piercing Overview": {
			"manual": {
				"hand": [
					{
						"name": "assign_defence",
						"subject": "target",
						"amount": 0,
						"set_to_mod": true,
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
						"subject": "previous",
						"modification": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("effect_stacks"),
					},
				],
			},
		},
		"Rubber Eggs": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.rubber_eggs.name,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Hard Rubber Eggs": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.rubber_eggs.name,
						"subject": "dreamer",
						"modification": 1,
						"upgrade_name": "hard",
					},
				],
			},
		},
		"Bouncy Rubber Eggs": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.rubber_eggs.name,
						"subject": "dreamer",
						"modification": 1,
						"upgrade_name": "bouncy",
					},
				],
			},
		},
		"The Joke": {
			"manual": {
				"hand": [
					{
						"name": "custom_script",
						"subject": "target",
						"is_cost": true,
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					}
				],
			},
		},
		"Nunclucks": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.nunclucks.name,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Gummiraptor": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 10,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "modify_damage",
						"is_cost": true,
						"amount": 10,
						"tags": ["Attack"],
						"subject": "previous",
						"filter_gummiraptor": true,
					}
				],
			},
		},
		"Cocky Retort": {
			"manual": {
				"hand": [
					# We have a function to discard manually to ensure
					# it's not counted for checking if the hand is full
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "self",
					},
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": 8,
					},
					{
						"name": "draw_cards",
						"card_count": 1,
					},
				],
			},
		},
		"Rapid Encirclement": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
						"subject": "boardseek",
						"subject_count": "all",
						"modification": 2,
						"filter_state_seek": [{
							"filter_group": "EnemyEntities",
						}],
					}
				],
			},
		},
		"Barrel Through": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 8,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "custom_script",
						"subject": "previous",
					},
				],
			},
		},
		"Intimidate": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
						"subject": "boardseek",
						"subject_count": "all",
						"modification": 2,
						"filter_state_seek": [{
							"filter_group": "EnemyEntities",
						}],
					}
				],
			},
		},
		"Cheeky Approach": {
			"manual": {
				"hand": [
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": 10,
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
						"subject": "target",
						"is_cost": true,
						"modification": 3,
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					}
				],
			},
		},
		"Laugh at Danger": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.laugh_at_danger.name,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Towering Presence": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"tags": ["Attack"],
						"amount": "per_defence",
						"per_defence": {
							"subject": "dreamer",
						},
					},
				],
			},
		},
		"Unassailable": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.unassailable.name,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Audacity": {
			"manual": {
				"hand": [
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": 8,
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.fortify.name,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Boast": {
			"manual": {
				"hand": [
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": "per_defence",
						"per_defence": {
							"subject": "dreamer",
						},
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.fortify.name,
						"subject": "dreamer",
						"modification": 0,
						"set_to_mod": true
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": cfc.NMAP.forgotten,
					},
				],
			},
		},
		"Solid Understanding": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 5,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": 5,
					},
				],
			},
		},
		"No Second Thoughts": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.fortify.name,
						"subject": "dreamer",
						"modification": 2,
					},
				],
			},
		},
		"High Morale": {
			"manual": {
				"hand": [
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "self",
					},
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 6,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "move_card_to_container",
						"subject": "tutor",
						"src_container":  cfc.NMAP.deck,
						"dest_container":  cfc.NMAP.hand,
						"filter_state_tutor": [
							{
								"filter_properties": {
									"Tags": Terms.ACTIVE_EFFECTS.fortify.name
								}
							}
						],
					},
				],
			},
		},
		"Confident Slap": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
						"subject": "target",
						"is_cost": true,
						"modification": 5,
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					}
				],
			},
		},
		"Swoop": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 8,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
						"filter_dreamer_effect": Terms.ACTIVE_EFFECTS.impervious.name,
						"filter_stacks": 0,
						"comparison": "eq",
					},
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 12,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
						"filter_dreamer_effect": Terms.ACTIVE_EFFECTS.impervious.name,
						"filter_stacks": 1,
						"comparison": "ge",
					},
				],
			},
		},
		"Drag and Drop": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 10,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "custom_script",
						"subject": "previous",
					},
				],
			},
		},
		"Running Start": {
			"manual": {
				"hand": [
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "self",
					},
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 6,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "move_card_to_container",
						"subject": "tutor",
						"src_container":  cfc.NMAP.deck,
						"dest_container":  cfc.NMAP.hand,
						"filter_state_tutor": [
							{
								"filter_properties": {
									"Tags": Terms.ACTIVE_EFFECTS.impervious.name
								}
							}
						],
					},
				],
			},
		},
		"Master of Skies": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.master_of_skies.name,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Zen of Flight": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.zen_of_flight.name,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Loop de loop": {
			"manual": {
				"hand": [
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": 7,
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.buffer.name,
						"subject": "dreamer",
					}
				],
			},
		},
		"Headless": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.buffer.name,
						"subject": "dreamer",
						"modification": 4
					}
				],
			},
		},
		"Utterly Ridiculous": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "boardseek",
						"subject_count": "all",
						"tags": ["Attack"],
						"amount": 20,
						"filter_state_seek": [{
							"filter_group": "EnemyEntities",
						}],
					}
				],
				"filter_per_effect_stacks": {
					"subject": "boardseek",
					"subject_count": "all",
					"filter_state_seek": [{
						"filter_group": "EnemyEntities",
					}],
					"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
					"filter_stacks": 6,
					"comparison": "ge",
				}
			},
		},
		"Ventriloquism": {
			"manual": {
				"hand": [
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "self",
					},
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 8,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "move_card_to_container",
						"subject": "tutor",
						"src_container":  cfc.NMAP.deck,
						"dest_container":  cfc.NMAP.hand,
						"filter_state_tutor": [
							{
								"filter_properties": {
									"Tags": Terms.ACTIVE_EFFECTS.disempower.name
								}
							}
						],
					},
				],
			},
		},
		"unnamed_card_1": {
			"manual": {
				"hand": [
					{
						"name": "move_card_to_container",
						"src_container": cfc.NMAP.discard,
						"dest_container": cfc.NMAP.deck,
						"subject_count": "all",
						"subject": "index",
						"subject_index": "top",
					},
					{
						"name": "shuffle_container",
						"dest_container": cfc.NMAP.deck,
					},
					{
						"name": "autoplay_card",
						"src_container": cfc.NMAP.deck,
						"subject_count": 1,
						"subject": "index",
						"subject_index": "random",
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": cfc.NMAP.forgotten,
					},
				],
			},
		},
		"unnamed_card_2": {
			"manual": {
				"hand": [
					{
						"name": "custom_script",
						"subject": "boardseek",
						"subject_count": "all",
						"filter_state_seek": [{
							"filter_group": "EnemyEntities",
						}],
					}
				],
			},
		},
		"unnamed_card_3": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "boardseek",
						"amount": 8,
						"subject_count": "all",
						"tags": ["Attack"],
						"filter_state_seek": [{
							"filter_group": "EnemyEntities",
						}],
					},
				],
			},
		},
		"Absurdity Unleashed": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.absurdity_unleashed.name,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Dread": {
			"manual": {
				"hand": [
					{
						"name": "remove_card_from_deck",
						"subject": "self",
					},
				],
			},
		},
		"unnamed_card_4": {
			"manual": {
				"hand": [
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": 11,
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": cfc.NMAP.forgotten,
					},
				],
			},
			"on_player_turn_ended": {
				"hand": [
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": cfc.NMAP.forgotten,
					},
				],
			},
		},
		"Change of Mind": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("damage_amount"),
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": cfc.NMAP.deck,
					},
					{
						"name": "shuffle_container",
						"dest_container": cfc.NMAP.deck,
					},
				],
			},
		},
		"Brilliance": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.brilliance.name,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Recall": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.recall.name,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Eureka!": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.eureka.name,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Rapid Theorizing": {
			"manual": {
				"hand": [
					# We have a function to discard manually to ensure
					# it's not counted for checking if the hand is full
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "self",
					},
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": 8,
					},
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": 2,
						"filter_event_count": {
							"event": "deck_shuffled",
							"filter_count": 1,
							"comparison": "ge",
						}
					},
					{
						"name": "draw_cards",
						"card_count": 1,
						"filter_turn_event_count": {
							"event": "deck_shuffled",
							"filter_count": 1,
							"comparison": "ge",
						}
					},
				],
			},
		},
		"Wild Inspiration": {
			"manual": {
				"hand": [
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "self",
					},
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.forgotten,
						"src_container": cfc.NMAP.deck,
						"subject": "index",
						"subject_index": "top",
						"is_cost": true,
					},
					{
						"name": "mod_counter",
						"counter_name": "immersion",
						"modification": 1,
					},
					{
						"name": "draw_cards",
						"card_count": 2,
					},
				],
			},
		},
		"unnamed_card_5": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 10,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "nested_script",
						"nested_tasks": [
							{
								"name": "move_card_to_container",
								"is_cost": true,
								"subject": "index",
								"subject_count": "all",
								"subject_index": "top",
								SP.KEY_NEEDS_SELECTION: true,
								SP.KEY_SELECTION_COUNT: 2,
								SP.KEY_SELECTION_TYPE: "equal",
								SP.KEY_SELECTION_OPTIONAL: true,
								SP.KEY_SELECTION_IGNORE_SELF: true,
								"src_container": cfc.NMAP.hand,
								"dest_container": cfc.NMAP.discard,
							},
							{
								"name": "move_card_to_container",
								"subject": "self",
								"dest_container": cfc.NMAP.deck,
							},
							{
								"name": "shuffle_container",
								"dest_container": cfc.NMAP.deck,
							},
						]
					}
				],
			},
		},
		"It's alive!": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 12,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "modify_damage",
						"subject": "previous",
						"amount": "per_encounter_event_count",
						"tags": ["Attack"],
						"per_encounter_event_count": {
							"event_name": "deck_shuffled",
							"multiplier": 2,
						}
					},
				],
			},
		},
		"Detect Weaknesses": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 9,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
						"subject": "previous",
						"modification": 2,
						"filter_turn_event_count": {
							"event": "deck_shuffled",
							"filter_count": 1,
							"comparison": "ge",
						}
					},
				],
			},
		},
	}
	return(_prepare_scripts(scripts, card_name))

# Takes care to return the correct script, even for card with standard upgrades
func _prepare_scripts(all_scripts: Dictionary, card_name: String) -> Dictionary:
	# When a the "Fleeting" prepend has been added to a card upgrade
	# It means the card is forgotten after using it.
	# This is the ScEng task that does this, and it is automatically appended
	# to the card's normal scripts.
	# We cannot make this into a const as it refers via NMAP
	var FLEETING_TASK := {
		"name": "move_card_to_container",
		"subject": "self",
		"dest_container": cfc.NMAP.forgotten,
	}
	var script_name := card_name
	var break_loop := false
	var special_destination = null
	for script_id in all_scripts:
		for prepend in SAME_SCRIPT_MODIFIERS:
			var card_name_with_unmodified_scripts = prepend + ' ' + script_id
			if card_name == card_name_with_unmodified_scripts:
				script_name = script_id
				if prepend in ["Ephemeral", "Fleeting"]:
					special_destination = prepend
				break_loop = true
				break
		if break_loop: break
	# We can mark which script to reuse in each card's definition
	# This allows us to reuse scripts, using different names than the prepends
	# in SAME_SCRIPT_MODIFIERS
	if cfc.card_definitions[card_name].has("_reuse_script"):
		script_name = cfc.card_definitions[card_name]["_reuse_script"]
	# We return only the scripts that match the card name and trigger
	var ret_script = all_scripts.get(script_name,{}).duplicate(true)
	# We use this trick to avoid creating a whole new script for the ephemeral
	# upgraded versions, just to add the "remove from deck" task
	match special_destination:
		"Ephemeral":
			ret_script["manual"]["hand"].append(EPHEMERAL_TASK)
		"Fleeting":
			ret_script["manual"]["hand"].append(FLEETING_TASK)
	return(ret_script)
