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
	"journal_description": """
It was the unending cackle that did it. I'd had enough. 
I turned to face my tormentors and found myself between [url={torment_tag1}]a pair of featureless creeps laughing[/url]. 
"What's so funny?" I demanded. My voice sounded thin, even to my own ears. 
"You," they replied in unison, their laughter redoubling. 
I tried to lunge at them but they side-stepped easily, still laughing uncontrollably. 
Suddenly furious, I screamed at them; a anguished, keening sound that echoed in the emptiness around us. 
They only laughed harder and danced away from me again as if this were the most amusing thing they'd ever seen
""",
	"journal_reward": """
"ENOUGH!" I roared, and they finally stopped, still grinning their awful grins. "I don't know who you are or what you want from me, but I'm done playing your games. So just go away and leave me alone!" For a moment they simply stared at me; then slowly, ever so slowly, their grins widened even further until their mouths threatened to split open from the effort. And then they dissolved into laughter once more and faded away until I was left standing alone in the darkness." Standing up to my fear made me feel stronger than before.
""",
	"journal_art": "res://assets/journal/torments/The Laughing One.jpg",
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
}


const Fearmonger = {
	"journal_description": """
[url={torment_tag1}]Three eyes staring at me[/url], the first was a piercing blue that seemed to bore through me, the second was a deep black that hid my true nature, and the third was a bright yellow that I couldn't look away from.
I felt a bit dizzy. I had the sensation that I was falling. My stomach lurched, and my breath caught in my throat. It all felt so real. I was floating in the middle of the night, staring at the third eye, and I couldn't move. I had to look away.
""",
	"journal_reward": """
The experience was definitely strange, and it left me feeling a bit unsettled. It's hard to say what exactly the owl represented, but it seemed to be some sort of symbol of wisdom or knowledge. Perhaps the three eyes represented different aspects of knowledge (past, present, and future?) or different ways of seeing things (logic, emotion, intuition?). In any case, the experience taught me that there is more to life than what we can see with our physical eyes. There are other ways of knowing and understanding the world around us.
""",
	"journal_art": "res://assets/journal/torments/Fearmonger.jpg",
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
"""It was dark as I was standing in an open field. A light flickered in the dark, filling my body with suspense as I wondered what it was coming from. 
I remember In the distance I could see [url={torment_tag1}]a grotesque entity move towards me[/url], the green flame flickered from the lamp attached to its strange head-body hybrid, illuminating the grueling faces it possessed. 
It started to tell me what I was and had become. I began to doubt myself and I felt like everything that I stood for was slowly burning away inside of me. 
I pleaded for it to go away, but I knew I couldn't shake it. The dark field I was standing in had erupted into green flames and in the light I was now face-to-face with the two-faced abomination.
""",
	"journal_reward":\
		"In the end, I had learned to overcome the doubt. I wouldn't let them gaslight me anymore. The ugly entity was crippled on the ground breathing out puffs of smoke as I pondered at my triumph. The entity ascended upwards and screamed at me in sheer exasperation and embarassment as it flew away. I knew that that was not the last time I was going to have to confront them. But now, I won't let anyone question my reality.",
	"journal_art": "res://assets/journal/torments/Gaslighter.jpg",
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
}


const Murmurs = {
	"journal_description":\
"""I thought I heard [url={torment_tag1}]murmurs in the wind[/url]. Were they talking about [i]that[/i] time..? 
By the minute, I was getting more certain that they were talking about me, and this had only left me more upset. 
Their whispers lingered in the air, getting more acerbic by the second.
""",
	"journal_reward":\
"""Their blame and resentment had me at my breaking point. Yet I stood firm them and reinforced my self-esteem. At this point, I had learned life is too short to keep grudges.
""",
	"journal_art": "res://assets/journal/torments/Murmurs.jpg",
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
}


const TheCritic = {
	"journal_description": """
I was in the middle of my usual morning jog when I noticed them. 
At first I thought they were birds, but then I realized they were something else entirely. 
They were [url={torment_tag1}]strange entities with comically enlarged sense organs[/url] that started circling me and pointing out all my flaws. 
It was disconcerting to say the least, especially since I had no idea what they were or where they came from.
""",
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"journal_art": "res://assets/journal/torments/The Critic.jpg",
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
}


#Keywords [dream, argument, clown, torment, philosphy, calm, surreality, humanism, ennui, existentialism]
#Summary  [I somehow ended in a peculiar argument with a clown.]
#Avoided concepts [woke up, wake up, awaken]
const Clown = {
	"journal_description": """
I found myself in the middle of an argument [url={torment_tag1}]with a clown[/url]. It was a surreal experience, and I couldn't quite make sense of what was happening. The clown seemed to be tormenting me, but I wasn't sure why. Suddenly, I felt an overwhelming sense of ennui wash over me. It was as if nothing mattered any more. All that existed was this pointless argument with the clown.
""",
	"journal_reward": """
Suddenly, I realized that the clown wasn't really worth getting so worked up over. It was just a silly creature, with no real understanding of anything. In the grand scheme of things, it didn't really matter what it said or did. 

With that realization, I felt a sense of calm come over me. The ennui dissipated and I was able to see things more clearly. This whole confrontation with the clown was an exercise in existentialism; it made me confront the meaninglessness of life head-on. But eventually, I overcame that feeling and moved on.
""",
	"journal_art": "res://assets/journal/torments/Clown.jpg",
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
}


const Butterfly = {
	"journal_description":\
		'What a [url={torment_tag1}]depressive butterfly[/url].',
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"journal_art": "res://assets/journal/torments/Butterfly.jpg",
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
}


const BrokenMirrors = {
	"journal_description":\
		'Am I cursed [url={torment_tag1}]or is it just bad luck[/url]?',
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"journal_art": "res://assets/journal/torments/Broken Mirror.jpg",
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
	"journal_art": "res://assets/journal/torments/pialephant.jpg",
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
}
const TheLightCalling = {
	"journal_description":\
		'At one point, I felt like I was having [url={torment_tag1}]a near death experience[/url].',
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"journal_art": "res://assets/journal/torments/The Light Calling.jpg",
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
}
const Squirrel = {
	"journal_description":\
		'I found myself facing off [url={torment_tag1}]with a squirrel giving me the stink-eye[/url].',
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"journal_art": "res://assets/journal/torments/Squirrel.jpg",
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
}
const Baby = {
	"journal_description":\
		'I had to take care of [url={torment_tag1}]a fussy baby[/url]. I am responsible enough?',
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"journal_art": "res://assets/journal/torments/baby.jpeg",
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
	'journal_art': "res://assets/journal/advanced/Labyrinth.jpg",
}
const Bully = {
	"name": "Bully",
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Elites/Bully.tscn")],
	"journal_description":\
		'My mind took me back to uncomfortable memories of schoolyard bullying.',
	"journal_reward":\
		'This time, I fortunately knew how to respond.',
	'journal_art': "res://assets/journal/advanced/Bully.jpg",
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
	'journal_art': 
		[
			"res://assets/journal/advanced/Narcissus/Narcissus1.jpg", 
			"res://assets/journal/advanced/Narcissus/Narcissus2.jpg", 
			"res://assets/journal/advanced/Narcissus/Narcissus3.jpg", 
			"res://assets/journal/advanced/Narcissus/Narcissus4.jpg", 
			"res://assets/journal/advanced/Narcissus/Narcissus5.jpg"
		],
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
