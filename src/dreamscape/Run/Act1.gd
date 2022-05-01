class_name Act1
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

const TheLaughingOnes = {
	"journal_description":\
		'I found myself between [url={torment_tag1}]a pair of featureless creeps laughing[/url] at me.',
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.THE_LAUGHING_ONE,
			},
			{
				"definition": EnemyDefinitions.THE_LAUGHING_ONE,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.THE_LAUGHING_ONE,
			},
			{
				"definition": EnemyDefinitions.THE_LAUGHING_ONE,
			},
			{
				"definition": EnemyDefinitions.THE_LAUGHING_ONE,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.THE_LAUGHING_ONE,
				"health_modifier": -7,
			},
			{
				"definition": EnemyDefinitions.THE_LAUGHING_ONE,
				"health_modifier": -5,
			},
			{
				"definition": EnemyDefinitions.THE_LAUGHING_ONE,
				"health_modifier": -5,
			},
			{
				"definition": EnemyDefinitions.THE_LAUGHING_ONE,
				"health_modifier": -8,
			}
		],
	},
	"journal_art": "res://assets/journal/torments/the_laughing_one.jpeg",
}


const Fearmonger = {
	"journal_description":\
		'Was that [url={torment_tag1}]a curious owl with three eyes[/url] staring at me?',
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"journal_art": "res://assets/journal/torments/fearmonger.jpeg",
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.FEARMONGER,
				"health_modifier": -30,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.FEARMONGER,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.FEARMONGER,
				"health_modifier": -20,
			},
			{
				"definition": EnemyDefinitions.FEARMONGER,
				"health_modifier": -20,
			},
		],
	},
}


const Gaslighter = {
	"journal_description":\
		"It was dark, with only an eerie hue of green shining across the place.\n"\
		+ "I was standing in an open field, scattered with unidentifiable brush and weeds. A light flickered in the dark, filling my body with suspense, as I wondered what it was coming from. I could recall more green embers in the dark that popped into existence and they danced around me in spiraling circles.\n"\
		+ "I heard a faint chant from them, as they sang a morbid song about how \"I had got it all wrong\", and \"how I'm not thinking straight.\" I've heard it once before, and the cryptic tune continued to eat away at me as it got louder and louder.\n"\
		+ "I had shouted at the top of my lungs for them to stop, and in an instance they had vaporized into smoke, which eventually had thickened into a fog.\n"\
		+ "Asserting myself felt good, but the smoke had hurt my lungs, so I tried to waft away the smoke in hopes it would clear."\
		+ "I remember In the distance I could see a grotesque spherical entity move towards me. At first I couldn't tell what it was, but as it came closer I could faintly see what it looked like, the green flame flickered from the lamp attached to its bodyless head illuminating the multitude of faces it possessed.\n"\
		+ "My mind told me to run, but the echoing sound of a whisper in my ear told me that I couldn't, it told me that I shouldn't, and that I didn't.\n"\
		+ "As the whispers became screams, my conscience and esteem was overtaken by this corrupt entity, and there was nothing to do but watch it's ugly green faces come closer, as the screaming became louder and the words became angrier and angrier. I started to doubt myself, everything that I stood for was slowly burning away inside of me, and pleaded for it to stop.\n"\
		+ "I tried to reassure myself that I was not the horrible thing it said I was, and the things that It told me that I had did, but in the end, I couldn't shake it away.\n"\
		+ "The dark field I was standing in had erupted into green flames as I came face to face with [url={torment_tag1}]the two-faced abomination[/url].",
	"journal_reward":\
		"In the end, I had learned to overcome the doubt, as the smoke cleared, and the sun began to rise. I wouldn't let them gaslight me anymore, since I knew deep in my heart, that I am who I say I am, and no one can tell me otherwise. I could see the ugly entity shriveled and crippled on the ground breathing out exasperated puffs of smoke. The flame that had once burnt me before had nearly gone out, but something didn't feel right. The flame sparked to life, fortunately I had not been met by hostility though. the entity ascended to the ground, looked me dead in the eyes, and screamed at me in sheer exasperation, as it flew away. I knew that that was not the last time I was going to have to confront them. But lets just hope that next time, my reality is solid as I know it is.",
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.GASLIGHTER,
				"health_modifier": -20,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.GASLIGHTER,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.GASLIGHTER,
				"health_modifier": +10,
				"starting_defence": +10,
			},
		],
	},
	"journal_art": "res://assets/enemies/gaslighter.png",
}


const Murmurs = {
	"journal_description":\
		'I thought I heard [url={torment_tag1}]murmurs on the wind[/url]. Were they talking about that time..?',
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.MURMURS,
				"health_modifier": -15,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.MURMURS,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.thorns.name,
						"stacks": 1
					}
				]
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.MURMURS,
				"health_modifier": +30,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.thorns.name,
						"stacks": 4
					}
				]
			},
		],
	},
	"journal_art": "res://assets/journal/torments/murmurs.jpeg",
}


const TheCritic = {
	"journal_description":\
		'Strange entities with comically enlarged sense organs [url={torment_tag1}]started circling me, and pointing out all my flaws[/url].',
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.THE_CRITIC,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.strengthen.name,
						"stacks": 2
					}
				]
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.THE_CRITIC,
			},
			{
				"definition": EnemyDefinitions.THE_CRITIC,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.THE_CRITIC,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.strengthen.name,
						"stacks": 2
					}
				]
			},
			{
				"definition": EnemyDefinitions.THE_CRITIC,
				"health_modifier": +25,
			},
		],
	},
	"journal_art": "res://assets/enemies/the_critic.png",
}


const Clown = {
	"journal_description":\
		'I somehow ended in a peculiar argument [url={torment_tag1}]with a clown[/url].',
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.CLOWN,
				"health_modifier": -10,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.CLOWN,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.CLOWN,
				"starting_defence": +20,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.fortify.name,
						"stacks": 1
					}
				]
			},
		],
	},
	"journal_art": "res://assets/journal/torments/clown.jpeg",
}


const Butterfly = {
	"journal_description":\
		'What a [url={torment_tag1}]depressive butterfly[/url].',
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.BUTTERFLY,
				"health_modifier": -10,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.BUTTERFLY,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.BUTTERFLY,
				"health_modifier": +10,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.strengthen.name,
						"stacks": 2
					}
				]
			},
		],
	},
	"journal_art": "res://assets/journal/torments/butterfly.jpeg",
}


const BrokenMirrors = {
	"journal_description":\
		'Am I cursed [url={torment_tag1}]or is it just bad luck[/url]?',
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.BROKEN_MIRROR,
				"health_modifier": -12,
			},
			{
				"definition": EnemyDefinitions.BROKEN_MIRROR,
				"health_modifier": -12,
			},
			{
				"definition": EnemyDefinitions.BROKEN_MIRROR,
				"health_modifier": -12,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.BROKEN_MIRROR,
			},
			{
				"definition": EnemyDefinitions.BROKEN_MIRROR,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.BROKEN_MIRROR,
				"starting_defence": +10,
			},
			{
				"definition": EnemyDefinitions.BROKEN_MIRROR,
				"starting_defence": +10,
			},
		],
	},
	"journal_art": "res://assets/journal/torments/broken_mirror.jpg",
}

const Pialephant = {
	"journal_description":\
"""I felt a feeling of excitement wash over me, as I heard a rumble in the clouds under my feet. 
I had thought it was a storm at first, but I had realized it was the circus coming straight towards me with great surprise! 
The drums boomed while the music and laughter blared louder as they were getting closer. 
My anticipation was met with concern, as I noticed they were not slowing down. 
In the distance I could hear the hastened sliding of piano keys evoking the sound of thunder as [url={torment_tag1}]a behemoth was charging straight towards me[/url]. 
This was no orchestra I wanted to be overrun by!
""",
	"journal_reward":\
"""Instead of letting my shock overtake me, I had to make some notes for a balloon as the gargantuan beast punted me through the clouds in the sound of a sonata. 
Hopefully it didn’t play something sharp, or else my balloon would become a corny pop song! 
Luckily, I had just found I was able to catch myself in the music, because I’d B-flat on the ground otherwise.
""",
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.PIALEPHANT,
				"health_modifier": -30,
				"rebalancing": {
					"Stress": -2,
					"Perplex": -2
				}
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.PIALEPHANT,
				"health_modifier": 0,
				"rebalancing": {
					"Stress": 0,
					"Perplex": 0
				}
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.PIALEPHANT,
				"starting_defence": +20,
				"rebalancing": {
					"Stress": +2,
					"Perplex": +2
				}
			},
		],
	},
	"journal_art": "res://assets/journal/torments/pialephant.jpg",
}
const TheLightCalling = {
	"journal_description":\
		'At one point, I felt like I was having [url={torment_tag1}]a near death experience[/url].',
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.THE_LIGHT_CALLING,
				"health_modifier": -10,
				"rebalancing": {
					"Stress": -1,
				}
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.THE_LIGHT_CALLING,
				"health_modifier": 0,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.THE_LIGHT_CALLING,
				"starting_defence": +12,
				"rebalancing": {
					"Stress": +1,
				}
			},
		],
	},
	"journal_art": "res://assets/journal/torments/the_light_calling.jpeg",
}
const Squirrel = {
	"journal_description":\
		'I found myself facing off [url={torment_tag1}]with a squirrel giving me the stink-eye[/url].',
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.SQUIRREL,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.SQUIRREL,
				"starting_defence": +3,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.quicken.name,
						"stacks": 1
					}
				]
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.SQUIRREL,
				"starting_defence": +7,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.quicken.name,
						"stacks": 2
					}
				],
			},
		],
	},
	"journal_art": "res://assets/journal/torments/squirrel.jpg",
}
const Baby = {
	"journal_description":\
		'I had to take care of [url={torment_tag1}]a fussy baby[/url]. I am responsible enough?',
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.BABY,
				"health_modifier": -10,
				"starting_intent": 0
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.BABY,
				"starting_intent": 0,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.BABY,
				"starting_intent": 0,
				"health_modifier": +15,
			},
		],
	},
	"journal_art": "res://assets/journal/torments/baby.jpeg",
}
#	{
#		"journal_description":\
#			'I found myself cowering before [url={torment_tag1}]a three-eyed owl[/url]'\
#			+ ' while someone in the distance was [url={torment_tag2}]laughing at my aprehension.[/url]',
#		"journal_reward":\
#			'Through overcoming that weird experience, I felt wiser.',
#		"enemies": [
#			{
#				"definition": EnemyDefinitions.FEARMONGER,
#			},
#			{
#				"definition": EnemyDefinitions.THE_LAUGHING_ONE,
#			},
#		]
#	},
#	{
#		"journal_description":\
#			'I discovered that [url={torment_tag1}]the lamps that should not be[/url] were multiplying.',
#		"journal_reward":\
#			'Through overcoming that weird experience, I felt wiser.',
#		"enemies": [
#			{
#				"definition": EnemyDefinitions.GASLIGHTER,
#			},
#			{
#				"definition": EnemyDefinitions.GASLIGHTER,
#			},
#		],
#		"journal_art": "res://assets/journal/gaslighter.jpeg"),
#	},



const ENEMIES = {
	"TheLaughingOnes": TheLaughingOnes,
	"TheCritic": TheCritic,
	"Fearmonger": Fearmonger,
	"Murmurs": Murmurs,
	"Clown": Clown,
	"Butterfly": Butterfly,
	"BrokenMirrors": BrokenMirrors,
	"Pialephant": Pialephant,
	"TheLightCalling": TheLightCalling,
	"Baby": Baby,
	"Squirrel": Squirrel,
	"Gaslighter": Gaslighter,
}

const RushElite = {
	"name": "Labyrinth",
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Elites/RushElite.tscn")],
	"journal_description":\
		'I remember walls enclosing me and no obvious way out...',
	"journal_reward":\
		'I finally understood what these infinite twists and turns represented.',
	'journal_art': "res://assets/journal/advanced/labyrinth.jpeg",
}
const Bully = {
	"name": "Bully",
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Elites/Bully.tscn")],
	"journal_description":\
		'My mind took me back to uncomfortable memories of schoolyard bullying.',
	"journal_reward":\
		'This time, I fortunately knew how to respond.',
	'journal_art': "res://assets/journal/advanced/bully.jpeg",
}

const ELITES = {
	"RushElite": RushElite,
	"Bully": Bully
}

const Narcissus = {
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Bosses/Narcissus.tscn")],
	"journal_description":\
		'I found someone I am sure I know, but I can\'t quite remember who.'\
		+ 'I found them gazing in a mirror, or was it a lake? They turned their attention to me...',
	"journal_reward":\
		'Through the many lies and denials, [url=boss_card_draft]I cornered the truth out of them.[/url]'\
		+ 'and for once felt like [url=boss_artifact]I was getting somewhere[/url].',
	'journal_art': "res://assets/journal/advanced/narcissus.jpeg",
}

const BOSSES := {
	"Narcissus": Narcissus
}


const NCE := {
	"easy": {
		"MonsterTrain": "res://src/dreamscape/Run/NCE/Act1/MonsterTrain.gd",
		"SlayTheSpire": "res://src/dreamscape/Run/NCE/Act1/SlayTheSpire.gd",
		"SleepOfOblivion": "res://src/dreamscape/Run/NCE/Act1/SleepOfOblivion.gd",
		"CrystalShattering": "res://src/dreamscape/Run/NCE/Act1/CrystalShattering.gd",
		"PathosForAnxiety": "res://src/dreamscape/Run/NCE/Act1/PathosForAnxiety.gd",
		"Dollmaker": "res://src/dreamscape/Run/NCE/Act1/Dollmaker.gd",
		"Greed": "res://src/dreamscape/Run/NCE/Act1/Greed.gd",
		"PopPsychologist1": "res://src/dreamscape/Run/NCE/Act1/PopPsychologist1.gd",
	},
	"risky": {
		"Highwire": "res://src/dreamscape/Run/NCE/Act1/Highwire.gd",
		"Spider": "res://src/dreamscape/Run/NCE/Act1/Spider.gd",
		# Recurrence appears in Act1, but if it's not encountered, it stays locked
		"Recurrence1": "res://src/dreamscape/Run/NCE/AllActs/Recurrence.gd",
	}
}

static func get_act_name() -> String:
	return(Act.ACT_NAMES.Act1)

static func get_act_number() -> int:
	return(1)
