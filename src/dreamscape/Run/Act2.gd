class_name Act2
extends Act

"""
The enemies list, is a list of dictionaries, which define which enemy to spawn
in each encounter. You can also optionally specified starting effects
for each enemy, as well as a specific intent to start with. The intent
Should be a valid index within the intents available for that enemy

As an example:

		"enemies": {
			"hard": [
				{
					"definition": EnemyDefinitions.THE_LAUGHING_ONE,
					"starting_intent": 1
					"health_modifier": -10
					"starting_defence": 10
					"starting_effects": [
						{
							"name": Terms.ACTIVE_EFFECTS.vulnerable.name,
							"stacks": 5
						}
					]
				},
			]
		}
"""

const TrafficJam = {
	"journal_description":\
		'I started dreaming about my [url={torment_tag1}]daily commute traffic jam[/url].',
	"journal_reward":\
		'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.TRAFFICJAM,
				"health_modifier": -20,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.TRAFFICJAM,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.TRAFFICJAM,
				"health_modifier": -20,
			},
			{
				"definition": EnemyDefinitions.TRAFFICJAM,
				"health_modifier": -20,
			},
		],
	},
#	"journal_art": preload("res://assets/journal/the_laughing_one.jpeg"),
}

const Mouse = {
	"journal_description":\
		'I was having tea with [url={torment_tag1}]a rodent[/url]. It was explaining the pitfalls of overpopulation.',
	"journal_reward":\
		'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.MOUSE,
				"health_modifier": -10,
				"starting_intent": 0,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.rebalance.name,
						"stacks": 3
					}
				]
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.MOUSE,
				"starting_intent": 1,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.rebalance.name,
						"stacks": 2
					}
				]
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.MOUSE,
				"starting_intent": 1,
				"starting_defence": +12,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.rebalance.name,
						"stacks": 1
					}
				]
			},
		],
	},
#	"journal_art": preload("res://assets/journal/the_laughing_one.jpeg"),
}

const TheExam = {
	"journal_description":\
		"The bell rang and I had to get back into class."\
			+ "[url={torment_tag1}]It was time for the test.[/url]",
	"journal_reward":\
		'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.THE_EXAM,
				"health_modifier": -20,
				"starting_intent": 0,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.rebalance.name,
						"stacks": 1
					}
				]
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.THE_EXAM,
				"starting_intent": 0,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.rebalance.name,
						"stacks": 2
					}
				]
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.THE_EXAM,
				"starting_intent": 0,
				"health_modifier": 20,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.rebalance.name,
						"stacks": 3
					}
				]
			},
		],
	},
#	"journal_art": preload("res://assets/journal/the_laughing_one.jpeg"),
}
const TheVictim = {
	"journal_description":\
		"[url={torment_tag1}]They claimed I always hurt their feelings.[/url] "\
			+ "Was I in the wrong? I don't know anymore...",
	"journal_reward":\
		'Through overcoming that weird experience, [url=card_draft]I felt wiser.[/url]',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.THE_VICTIM,
				"health_modifier": -10,
				"starting_intent": 0,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.the_victim.name,
						"stacks": 4
					}
				]
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.THE_VICTIM,
				"starting_intent": 0,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.the_victim.name,
						"stacks": 3
					}
				]
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.THE_VICTIM,
				"health_modifier": +15,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.the_victim.name,
						"stacks": 2
					}
				]
			},
		],
	},
#	"journal_art": preload("res://assets/journal/the_laughing_one.jpeg"),
}


const ENEMIES = [
	TrafficJam,
	Mouse,
	TheExam,
	TheVictim,
]

const RushElite = {
	"scene": preload("res://src/dreamscape/CombatElements/Enemies/Elites/RushElite.tscn"),
	"journal_description":\
		'I remember walls enclosing me and no obvious way out...',
	"journal_reward":\
		'I finally understood what these infinite twists and turns represented.',
}
const Bully = {
	"scene": preload("res://src/dreamscape/CombatElements/Enemies/Elites/Bully.tscn"),
	"journal_description":\
		'My mind took me back to uncomfortable memories of schoolyard bullying.',
	"journal_reward":\
		'This time, I fortunately knew how to respond.',
}

const ELITES = [
	RushElite,
	Bully
]

const SurrealBoss = {
	"scene": preload("res://src/dreamscape/CombatElements/Enemies/Bosses/SurrealBoss.tscn"),
	"journal_description":\
		"The next dream I had was so incomprehensible, just trying to remember it makes my head hurt",
	"journal_reward":\
		"I don't claim to understand what I was seeing, [url=boss_card_draft]but eventually that vision faded.[/url]"\
		+ "but my mind was open to [url=boss_artifact]many new possibilities[/url].",
}

const BOSSES := {
	"Surreality": SurrealBoss
}

const NCE := [
	preload("res://src/dreamscape/Run/NCE/Act1/MonsterTrain.gd"),
	preload("res://src/dreamscape/Run/NCE/Act1/SlayTheSpire.gd"),
	preload("res://src/dreamscape/Run/NCE/Act1/SleepOfOblivion.gd"),
	preload("res://src/dreamscape/Run/NCE/Act1/MultipleOptions.gd"),
	preload("res://src/dreamscape/Run/NCE/Act1/PathosForAnxiety.gd"),
	preload("res://src/dreamscape/Run/NCE/Act1/Dollmaker.gd"),
	preload("res://src/dreamscape/Run/NCE/Act1/Greed.gd"),
	preload("res://src/dreamscape/Run/NCE/Act1/PopPsychologist1.gd"),
]

static func get_act_name() -> String:
	return("Deep Sleep")
