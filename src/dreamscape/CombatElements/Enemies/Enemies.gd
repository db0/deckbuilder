class_name EnemyDefinitions
extends Reference


## ACT 1
const GASLIGHTER:= {
	"Name": "Gaslighter",
	"Type": "Abuse",
	"Health": 50,
	"Intents": [
		{
			"intent_scripts": ["Stress:6"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:6"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Debuff:3:poison"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Perplex:10", "Stress:1"],
			"reshuffle": true,
		},
	],
	"_health_variability": 3,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_texture": preload("res://assets/enemies/gaslighter.png"),
	"_character_art": "A_Mc",
}
const FEARMONGER:= {
	"Name": "Fearmonger",
	"Type": "Abuse",
	"Health": 70,
	"Intents": [
		{
			"intent_scripts": ["Stress:8","Debuff:2:vulnerable"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:10"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:5","Stress:5"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Perplex:6","Stare"],
			"reshuffle": true,
		},
	],
	"_health_variability": 4,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_art_scene": "res://src/dreamscape/CombatElements/Enemies/Art/fearmonger.tscn",
	"_character_art": "insomniac_lemon",
}
const THE_LAUGHING_ONE:= {
	"Name": "The Laughing One",
	"Type": "Fear",
	"Health": 22,
	"Intents": [
		{
			"intent_scripts": ["Stress:2","Stress:2","Stress:2"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:1","Stress:2","Stress:3"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:3","Buff:1:strengthen"],
			"reshuffle": true,
			"max_in_a_row": 1,
		},
	],
	"_health_variability": 5,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_art_scene": "res://src/dreamscape/CombatElements/Enemies/Art/the_laughing_one.tscn",
	"_character_art": "insomniac_lemon",
}
const THE_CRITIC:= {
	"Name": "The Critic",
	"Type": "Fear",
	"Health": 37,
	"Intents": [
		{
			"intent_scripts": ["Stress:6"],
			"reshuffle": true,
		},
		{
			"intent_scripts": ["Debuff:3:vulnerable"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:9", "Perplex:4"],
			"reshuffle": true,
		},
	],
	"_health_variability": 4,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_texture": preload("res://assets/enemies/tapir.png"),
	"_character_art": "Delapouite",
}
const CLOWN:= {
	"Name": "Clown",
	"Type": "Phobia",
	"Health": 53,
	"Intents": [
		{
			"intent_scripts": ["Stress:7","Debuff:1:disempower"],
			"reshuffle": true,
		},
		{
			"intent_scripts": ["Debuff:3:disempower"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:12"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Perplex:12","Buff:1:fortify"],
			"reshuffle": false,
		},
	],
	"_health_variability": 3,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_texture": preload("res://assets/enemies/clown.png"),
	"_character_art": "Delapouite",
}
const BUTTERFLY:= {
	"Name": "Butterfly",
	"Type": "Phobia",
	"Health": 40,
	"Intents": [
		{
			"intent_scripts": ["Buff:3:strengthen"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:1","Stress:1", "Buff:2:armor"],
			"reshuffle": true,
		},
		{
			"intent_scripts": ["Stress:7"],
			"reshuffle": false,
		}
	],
	"_health_variability": 8,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_texture": preload("res://assets/enemies/butterfly.png"),
	"_character_art": "Lorc",
		}
const MURMURS := {
	"Name": "Murmurs",
	"Type": "Fear",
	"Health": 83,
	"Intents": [
		{
			"intent_scripts": ["Debuff:2:disempower", "Stress:4"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Buff:4:thorns"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:10"],
			"reshuffle": true,
		},
	],
	"_health_variability": 4,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_texture": preload("res://assets/enemies/sound-waves.png"),
	"_character_art": "Skoll"
}
const BROKEN_MIRROR:= {
	"Name": "Broken Mirror",
	"Type": "Phobia",
	"Health": 22,
	"Intents": [
		{
			"intent_scripts": ["Debuff:3:burn"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Debuff:2:burn","Perplex:7"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Perplex:10"],
			"reshuffle": true,
			"max_in_a_row": 1,
		},
	],
	"_health_variability": 2,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_texture": preload("res://assets/enemies/cracked-glass.png"),
	"_character_art": "Lorc"
}
const PIALEPHANT:= {
	"Name": "Pialephant",
	"Type": "Absurdity",
	"Health": 80,
	"Intents": [
		{
			"intent_scripts": ["Stress:20"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Perplex:14"],
			"reshuffle": true,
			"max_in_a_row": 2,
		},
	],
	"_health_variability": 10,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_texture": preload("res://assets/enemies/elephant.png"),
	"_character_art": "Delapouite"
}
const THE_LIGHT_CALLING := {
	"Name": "The Light Calling",
	"Type": "Existential",
	"Health": 50,
	"Intents": [
		{
			"intent_scripts": ["Lethargy:2","Stress:3"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Lethargy:1","Stress:8"],
			"reshuffle": true,
		},
		{
			"intent_scripts": ["Stress:11"],
			"reshuffle": false,
		},
	],
	"_health_variability": 8,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_texture": preload("res://assets/enemies/sunbeams.png"),
	"_character_art": "Lorc"
}
const SQUIRREL := {
	"Name": "A Squirrel",
	"Type": "Phobia",
	"Health": 40,
	"_is_ordered": true,
	"Intents": [
		{
			"intent_scripts": ["Perplex:5"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Perplex:5"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Perplex:5"],
			"reshuffle": false,
		},
		{
			"id": "explode",
			"intent_scripts": ["Stress:40", "Evident:50"],
			"reshuffle": true,
		},
	],
	"_health_variability": 3,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_texture": preload("res://assets/enemies/squirrel.png"),
	"_character_art": "Delapouite"
}
const BABY := {
	"Name": "Baby",
	"Type": "Phobia",
	"Health": 48,
	"Intents": [
		{
			"intent_scripts": ["Stress:12"],
			"reshuffle": true,
		},
		{
			"intent_scripts": ["Stress:8", "Debuff:1:marked"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:12"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:8", "Debuff:1:marked"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Delight"],
			"reshuffle": false,
			"max_uses": 1,
		},
	],
	"_health_variability": 2,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_texture": preload("res://assets/enemies/baby-face.png"),
	"_character_art": "Delapouite"
}

## ACT 2
const TRAFFICJAM := {
	"Name": "Traffic Jam",
	"Type": "Undefined",
	"Health": 70,
	"Intents": [
		{
			"intent_scripts": ["Stress:18", "Frustrate:10"],
			"reshuffle": true,
		},
		{
			"intent_scripts": ["Stress:10", "Dishearten:-5"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Perplex:12", "Dishearten:-3", "Frustrate:3"],
			"reshuffle": false,
		},
	],
	"_health_variability": 8,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_texture": preload("res://assets/enemies/traffic-lights-red.png"),
	"_character_art": "Delapouite"
}
const STUFFEDTOY := {
	"Name": "Stuffed Toy",
	"Type": "Phobia",
	"Health": 80,
	"Intents": [
		{
			"intent_scripts": ["Stress:7", "Stress:7", "Stress:7"],
			"reshuffle": true,
			"max_in_a_row": 2,
		},
		{
			"intent_scripts": ["Debuff:2:disempower", "Debuff:2:vulnerable"],
			"reshuffle": false,
		},
	],
	"_health_variability": 3,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_texture": preload("res://assets/enemies/polar-bear.png"),
	"_character_art": "Cathelineau"
}
const MOUSE := {
	"Name": "Mouse",
	"Type": "Phobia",
	"Health": 80,
	"Intents": [
		{
			"intent_scripts": ["Perplex:13"],
			"reshuffle": false,
			"max_uses": 1,
		},
		{
			"intent_scripts": ["Stress:20"],
			"reshuffle": false,
			"max_in_a_row": 1,
		},
		{
			"intent_scripts": ["Unfocus", "Perplex:10"],
			"reshuffle": true,
			"max_in_a_row": 1,
		},
	],
	"_health_variability": 4,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_texture": preload("res://assets/enemies/seated-mouse.png"),
	"_character_art": "Lorc"
}
const THE_EXAM := {
	"Name": "The Exam",
	"Type": "Fear",
	"Health": 100,
	"Intents": [
		{
			"intent_scripts": ["Pencils Ready"],
			"reshuffle": false,
			"max_uses": 1,
		},
		{
			"intent_scripts": ["Memory Failing"],
			"reshuffle": false,
			"max_uses": 3,
		},
		{
			"intent_scripts": ["Perplex:12", "Stress:12"],
			"reshuffle": true,
			"max_in_a_row": 1,
		},
		{
			"intent_scripts": ["Perplex:5", "Stress:15"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Perplex:15", "Stress:5"],
			"reshuffle": false,
		},
	],
	"_health_variability": 6,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_texture": preload("res://assets/enemies/notebook.png"),
	"_character_art": "Delapouite"
}
const THE_VICTIM := {
	"Name": "The Victim",
	"Type": "Abuse",
	"Health": 93,
	"Intents": [
		{
			"intent_scripts": ["Stress:8", "Stress:7", "Stress:6"],
			"reshuffle": true,
			"max_in_a_row": 2,
		},
		{
			"intent_scripts": ["Stress:16", "Buff:2:thorns", "Debuff:1:disempower"],
			"reshuffle": true,
			"max_in_a_row": 2,
		},
		{
			"intent_scripts": ["Perplex:10"],
			"reshuffle": false,
			"max_uses": 1,
			"sets_up_intent": "5stress",
		},
		{
			"id": "5stress",
			"intent_scripts": ["Stress:5", "Stress:5", "Stress:5", "Stress:5", "Stress:5", "Stress:5"],
			"reshuffle": false,
			"not_in_rotation": true,
		},
	],
	"_health_variability": 2,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_texture": preload("res://assets/enemies/slavery-whip.png"),
	"_character_art": "Lorc"
}
const IMPOSSIBLE_CONSTRUCTION := {
	"Name": "Impossible Construction",
	"Type": "Absurdity",
	"Health": 20,
	"Intents": [
		{
			"intent_scripts": ["Perplex:25", "Buff:1:fortify"],
			"reshuffle": false,
			"max_uses": 1,
		},
		{
			"intent_scripts": ["Debuff:5:vulnerable", "Stress:10", "Buff:1:fortify"],
			"reshuffle": false,
			"max_uses": 1,
		},
		{
			"intent_scripts": ["Stress:10", "Stress:10", "Buff:1:fortify"],
			"reshuffle": true,
			"max_in_a_row": 1,
		},
		{
			"intent_scripts": ["Stress:10", "Perplex:10", "Buff:1:fortify"],
			"reshuffle": false,
		},
	],
	"_health_variability": 1,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
#	"_texture": preload("res://assets/enemies/slavery-whip.png"),
	"_character_art": "Nobody"
}
const SILENT_TREATMENT := {
	"Name": "Silent Treatment", 
	"Type": "Abuse",
	"Health": 83,
	"Intents": [
		{
			"id": "perplex_group",
			"intent_scripts": ["PerplexGroup:8"],
			"reshuffle": true,
			"max_in_a_row": 2,
		},
		{
			"id": "buff_group",
			"intent_scripts": ["PerplexGroup:4", "BuffGroup:1:protection"],
			"reshuffle": false,
		},
		{
			"id": "enrage",
			"intent_scripts": ["Stress:7", "Stress:8", "Stress:9",],
			"not_in_rotation": true,
			"reshuffle": true,
		},
	],
	"_unlock_triggers": {
		"entity_killed": ["enrage"]
	},
	"_lock_triggers": {
		"entity_killed": ["perplex_group", "buff_group"],
	},
	"_health_variability": 4,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
#	"_texture": preload("res://assets/enemies/slavery-whip.png"),
	"_character_art": "Nobody"
}
const GUILT := {
	"Name": "Guilt", 
	"Type": "Abuse",
	"Health": 10,
	"Intents": [
		{
			"intent_scripts": ["Stress:15"],
			"reshuffle": true,
		},
		{
			"intent_scripts": ["Stress:8", "Stress:8"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:10", "Buff:1:strengthen"],
			"reshuffle": false,
		},
	],
	"_health_variability": 1,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
#	"_texture": preload("res://assets/enemies/slavery-whip.png"),
	"_character_art": "Nobody"
}
const VOID := {
	"Name": "Void", 
	"Type": "Absurdity",
	"Health": 132,
	"Intents": [
		{
			"intent_scripts": ["Stress:6","Stress:6"],
			"reshuffle": true,
			"max_in_a_row": 1,
		},
		{
			"intent_scripts": ["Increase Complexity"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:18", "Debuff:2:vulnerable"],
			"reshuffle": false,
			"max_uses": 3,
		},
	],
	"_health_variability": 8,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
#	"_texture": preload("res://assets/enemies/slavery-whip.png"),
	"_character_art": "Nobody"
}
const UNNAMED1 := {
	"Name": "Unnamed Torment 1", 
	"Type": "Absurdity",
	"Health": 100,
	"Intents": [
		{
			"intent_scripts": ["Stress:10","Summon Minion 1"],
			"reshuffle": true,
			"max_in_a_row": 1,
		},
		{
			"intent_scripts": ["Summon Minion 1", "PerplexGroup:5"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Debuff:1:marked", "Summon Minion 1"],
			"reshuffle": false,
			"max_uses": 5,
		},
	],
	"_health_variability": 4,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
#	"_texture": preload("res://assets/enemies/slavery-whip.png"),
	"_character_art": "Nobody"
}
const UNNAMED_MINION1 := {
	"Name": "Unnamed Minion 1", 
	"Type": "Absurdity",
	"Health": 10,
	"Intents": [
		{
			"intent_scripts": ["Stress:7", "Armor The Boss"],
			"reshuffle": true,
			"max_in_a_row": 2,
		},
		{
			"intent_scripts": ["Perplex:9", "Armor The Boss"],
			"reshuffle": false,
		},
	],
	"_health_variability": 4,
	"_texture_size_x": "60",
	"_texture_size_y": "60",
#	"_texture": preload("res://assets/enemies/slavery-whip.png"),
	"_character_art": "Nobody"
}
const SPECIAL_MINION1 := {
	"Name": "Special Minion 1", 
	"Type": "Absurdity",
	"Health": 10,
	"Intents": [
		{
			"intent_scripts": ["Stress:7"],
			"reshuffle": true,
			"max_in_a_row": 2,
		},
		{
			"intent_scripts": ["Debuff:1:disempower", "BuffGroup:1:armor"],
			"reshuffle": false,
		},
	],
	"_health_variability": 2,
	"_texture_size_x": "60",
	"_texture_size_y": "60",
#	"_texture": preload("res://assets/enemies/slavery-whip.png"),
	"_character_art": "Nobody"
}
const LIFE_PATH := {
	"Name": "Life Path", 
	"Type": "Fear",
	"Health": 72,
	"Intents": [
		{
			"intent_scripts": ["Stress:10"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:4", "PerplexGroup:5"],
			"reshuffle": true,
			"max_in_a_row": 3,
		},
		{
			"intent_scripts": ["Debuff:2:burn"],
			"reshuffle": false,
		},
	],
	"_health_variability": 5,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
#	"_texture": preload("res://assets/enemies/slavery-whip.png"),
	"_character_art": "Nobody"
}
const CRINGELORD:= {
	"Name": "Cringelord",
	"Type": "Fear",
	"Health": 97,
	"Intents": [
		{
			"intent_scripts": ["Stress:14"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:6","Stress:7"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Perplex:10","Stare","Stare"],
			"reshuffle": true,
			"max_in_a_row": 2,
		},
	],
	"_health_variability": 5,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
#	"_texture": preload("res://assets/enemies/slavery-whip.png"),
	"_character_art": "nobody",
}
const NIGHTMARE:= {
	"Name": "Nightmare",
	"Type": "Fear",
	"Health": 60,
	"Intents": [
		{
			"intent_scripts": ["Stress:15","Stress:15"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:5","Stress:5","Stress:5","Stress:5","Stress:5","Stress:5"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Stress:30"],
			"reshuffle": false,
		},
	],
	"_health_variability": 5,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
#	"_texture": preload("res://assets/enemies/slavery-whip.png"),
	"_character_art": "nobody",
}
const THEATRE_ACT := {
	"Name": "Theatre Act", 
	"Type": "Fear",
	"Health": 3,
	"_is_ordered": true,
	"Intents": [
		{
			"intent_scripts": ["Complicated Play"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Complicated Play"],
			"reshuffle": false,
		},
		{
			"intent_scripts": ["Act It Out"],
			"reshuffle": false,
		},
	],
	"_health_variability": 0,
	"_texture_size_x": "60",
	"_texture_size_y": "60",
	"_texture": preload("res://assets/enemies/theater-curtains.png"),
	"_character_art": "Delapouite"
}

const SUBMERGED := {
	"Name": "Submerged", 
	"Type": "Phobia",
	"Health": 94,
	"_is_ordered": true,
	"Intents": [
		{
			"intent_scripts": ["Stress:10", "SpawnCard:Suffocation:Discard","SpawnCard:Suffocation:Deck"],
			"reshuffle": true,
			"max_in_a_row": 2,
		},
		{
			"intent_scripts": ["Stress:15"],
			"reshuffle": true,
			"max_in_a_row": 2,
		},
	],
	"_health_variability": 5,
	"_texture_size_x": "120",
	"_texture_size_y": "120",
	"_texture": preload("res://assets/enemies/submerged.png"),
	"_character_art": "Nobody"
}
