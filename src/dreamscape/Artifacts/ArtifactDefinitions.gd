# Provides the metadata for each artifact. Their script is contained within
# The script file with the same name under "res://src/dreamscape/Artifacts/"
# Each artifact has an "amounts" key which is used populate both description
# and script. This allows us in the future to quickly tweak values without
# having to change multiple places
class_name ArtifactDefinitions
extends Reference

# Defines when an artifact's effects are active.
# This allows us to know when to trigger artifact effects.
enum EffectContext {
	# This artifact's effects are active only outside battle
	OVERWORLD
	# This artifact's effects are active only during a battle
	BATTLE
	# This artifact triggers its effect only in the shop
	SHOP
}

const GENERIC_ARTIFACT_ICON = preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png")
const GENERIC_BOSS_ARTIFACT_ICON = preload("res://assets/icons/artifacts/boss-key.png")

const MaxHealth := {
	"canonical_name": "MaxHealth",
	"name": "Stress ball",
	"description": "{artifact_name}: max {anxiety} inreased by {health_amount}",
	"icon": preload("res://assets/icons/artifacts/ball-heart.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Uncommon",
	"amounts": {
		"health_amount": 10
	},
	"linked_terms": [
		"player_health",
	],
}

const StartingHeal := {
	"canonical_name": "StartingHeal",
	"name": "Hot water bottle",
	"description": "{artifact_name}: At the start of each Ordeal, {relax} for {heal_amount}.",
	"icon": preload("res://assets/icons/artifacts/water-flask.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"heal_amount": 2
	},
	"linked_terms": [
		"relax",
	],
}

const EndingHeal := {
	"canonical_name": "EndingHeal",
	"name": "Coffee beans",
	"description": "{artifact_name}: At the end of each Ordeal, {relax} for {heal_amount}.",
	"icon": preload("res://assets/icons/artifacts/coffee-beans.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Starting",
	"amounts": {
		"heal_amount": 6
	},
	"linked_terms": [
		"relax",
	],
}

const FirstPowerAttack := {
	"canonical_name": "FirstPowerAttack",
	"name": "Rosetta stone",
	"description": "{artifact_name}: Your first {attack} each encounter is increased by {effect_amount}",
	"icon": preload("res://assets/icons/artifacts/stone-tablet.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"effect_amount": 8
	},
	"linked_terms": [
		"attack",
	],
}


const StartingCards := {
	"canonical_name": "StartingCards",
	"name": "Knapsack",
	"description": "{artifact_name}: At the start of each Ordeal, draw {draw_amount} cards.",
	"icon": preload("res://assets/icons/artifacts/knapsack.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"draw_amount": 2
	},
}


const RepressedEnemyBuff := {
	"canonical_name": "RepressedEnemyBuff",
	"name": "Fruscination",
	"description": "{artifact_name}: At the start of each Ordeal,"\
		+ " Gain {effect_stacks} {buffer} for each {mastery_amount} Frustration Mastery you have.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"effect_stacks": 1,
		"mastery_amount": 3
	},
	"linked_terms": [
		"buffer",
	],
}


const StartingImmersion := {
	"canonical_name": "StartingImmersion",
	"name": "Tiny coala friend",
	"description": "{artifact_name}: At the start of each Ordeal, gain {immersion_amount} {energy}.",
	"icon": preload("res://assets/icons/artifacts/koala.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"immersion_amount": 1
	},
	"linked_terms": [
		"energy",
	],
}


const StartingStrength := {
	"canonical_name": "StartingStrength",
	"name": "Mechanical eyeball",
	"description": "{artifact_name}: At the start of each Ordeal, gain {effect_stacks} {strengthen}.",
	"icon": preload("res://assets/icons/artifacts/eyeball.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"effect_stacks": 1
	},
	"linked_terms": [
		"strengthen",
	],
}


const StartingThorns := {
	"canonical_name": "StartingThorns",
	"name": "Crown of thorns",
	"description": "{artifact_name}: At the start of each Ordeal, gain {effect_stacks} {thorns}.",
	"icon": preload("res://assets/icons/artifacts/crown-of-thorns.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"effect_stacks": 4
	},
	"linked_terms": [
		"thorns",
	],
}


const StartingConfidence := {
	"canonical_name": "StartingConfidence",
	"name": "Epic mustache",
	"description": "{artifact_name}: At the start of each Ordeal, gain {defence_amount} {defence}.",
	"icon": preload("res://assets/icons/artifacts/mustache.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"defence_amount": 10
	},
	"linked_terms": [
		"defence",
	],
}


const ThickImmersion := {
	"canonical_name": "ThickImmersion",
	"name": "Weighted blanket",
	"description": "{artifact_name}: At that start of each Ordeal turn, gain {immersion_amount} {energy}. "\
		+ "This effects ends when your deck is reshuffled and you gain {effect_stacks} {vulnerable}.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"immersion_amount": 1,
		"effect_stacks": 3
	},
	"linked_terms": [
		"energy",
		"vulnerable",
	],
}


const ThickStrength := {
	"canonical_name": "ThickStrength",
	"name": "Extending eye",
	"description": "{artifact_name}: At that start of each Ordeal turn, gain {effect_stacks} {strengthen}. "\
		+ "This effects and all added {strengthen} ends when your deck is reshuffled.",
	"icon": preload("res://assets/icons/artifacts/eyestalk.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"effect_stacks": 1
	},
	"linked_terms": [
		"strengthen",
	],
}


const UpgradedAction := {
	"canonical_name": "UpgradedAction",
	"name": "Flashlight",
	"description": "{artifact_name}: {action} cards added to your deck receive {progress_amount} progress.",
	"icon": preload("res://assets/icons/artifacts/flashlight.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Uncommon",
	"amounts": {
		"progress_amount": 4
	},
}


const UpgradedControl := {
	"canonical_name": "UpgradedControl",
	"name": "Candle",
	"description": "{artifact_name}: {control} cards added to your deck receive {progress_amount} progress.",
	"icon": preload("res://assets/icons/artifacts/candle-light.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Uncommon",
	"amounts": {
		"progress_amount": 4
	},
}


const UpgradedUnderstanding := {
	"canonical_name": "UpgradedUnderstanding",
	"name": "Laser pointer",
	"description": "{artifact_name}: {understanding} cards added to your deck receive {progress_amount} progress.",
	"icon": preload("res://assets/icons/artifacts/target-laser.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Uncommon",
	"amounts": {
		"progress_amount": 6
	},
}


const UpgradedConcentration := {
	"canonical_name": "UpgradedConcentration",
	"name": "Lantern",
	"description": "{artifact_name}: {concentration} cards added to your deck receive {progress_amount} progress.",
	"icon": preload("res://assets/icons/artifacts/old-lantern.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Uncommon",
	"amounts": {
		"progress_amount": 5
	},
}


const ThinCardDraw := {
	"canonical_name": "ThinCardDraw",
	"name": "Light backpack",
	"description": "{artifact_name}: Every time you reshuffle the deck, draw {draw_amount} card.\n"\
			+ "This effect stops for the turn after you draw the same card two times.",
	"icon": preload("res://assets/icons/artifacts/light-backpack.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"draw_amount": 1
	},
}


const ResistDisempower := {
	"canonical_name": "ResistDisempower",
	"name": "An unblinking eye",
	"description": "{artifact_name}: You cannot receive {disempower} anymore.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.BATTLE,
	"rarity": "Rare",
	"linked_terms": [
		"disempower",
	],
}


const ResistPoison := {
	"canonical_name": "ResistPoison",
	"name": "Encyclopedia",
	"description": "{artifact_name}: Any time you would receive {poison} reduce it by {alteration_amount}.",
	"icon": preload("res://assets/icons/artifacts/book-pile.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"alteration_amount": 1
	},
	"linked_terms": [
		"poison",
	],
}


const ResistBurn := {
	"canonical_name": "ResistBurn",
	"name": "Secret garden",
	"description": "{artifact_name}: Any time you would receive {burn} reduce it by {alteration_amount}.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"alteration_amount": 1
	},
	"linked_terms": [
		"burn",
	],
}


const ResistVulnerable := {
	"canonical_name": "ResistVulnerable",
	"name": "Concrete shoes",
	"description": "{artifact_name}: You cannot receive {vulnerable} anymore.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.BATTLE,
	"rarity": "Rare",
	"linked_terms": [
		"vulnerable",
	],
}


const ImproveThorns := {
	"canonical_name": "ImproveThorns",
	"name": "White rose",
	"description": "{artifact_name}: Any time you would gain {thorns}, gain {alteration_amount} more.",
	"icon": preload("res://assets/icons/artifacts/rose.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"alteration_amount": 1
	},
	"linked_terms": [
		"thorns",
	],
}


const ImprovePoison := {
	"canonical_name": "ImprovePoison",
	"name": "The crushing weight of normality",
	"description": "{artifact_name}: Any time you would inflict {poison}, inflict {alteration_amount} more.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"alteration_amount": 1
	},
	"linked_terms": [
		"poison",
	],
}


const ImproveBurn := {
	"canonical_name": "ImproveBurn",
	"name": "Fancy lipstick",
	"description": "{artifact_name}: Any time you would inflict {burn}, inflict {alteration_amount} more.",
	"icon": preload("res://assets/icons/artifacts/lipstick.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"alteration_amount": 1
	},
	"linked_terms": [
		"burn",
	],
}


const ThickExplosion := {
	"canonical_name": "ThickExplosion",
	"name": "Clockwork bomb",
	"description": "{artifact_name}: The first time you reshuffle your deck because it run out of cards, "\
		+ "{attack} all torments for an amount equal to your discard pile size.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.BATTLE,
	"rarity": "Rare",
	"linked_terms": [
		"attack",
	],
}


const AccumulateEnemy := {
	"canonical_name": "AccumulateEnemy",
	"name": "Repressed frustration",
	"description": "{artifact_name}: Increase your repressed Frustration. {relax} for {heal_amount}",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.OVERWORLD,
	"rarity": "Common",
	"amounts": {
		"pathos_avg_multiplier": 4,
		"heal_amount": 30
	},
	"linked_terms": [
		"relax",
	],
}
const AccumulateRest := {
	"canonical_name": "AccumulateRest",
	"name": "Repressed lethargy",
	"description": "{artifact_name}: Increase your repressed Lethargy",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.OVERWORLD,
	"rarity": "Common",
	"amounts": {
		"pathos_avg_multiplier": 4
	},
}
const AccumulateNCE := {
	"canonical_name": "AccumulateNCE",
	"name": "Repressed curiosity",
	"description": "{artifact_name}: Increase your repressed Curiosity"\
			+ "Increase max {anxiety} by {anxiety_amount}",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.OVERWORLD,
	"rarity": "Common",
	"amounts": {
		"pathos_avg_multiplier": 4,
		"anxiety_amount": 3,
	},
}
const AccumulateShop := {
	"canonical_name": "AccumulateShop",
	"name": "Repress loneliness",
	"description": "{artifact_name}: Increase your repressed Loneliness",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.OVERWORLD,
	"rarity": "Common",
	"amounts": {
		"pathos_avg_multiplier": 4,
	},
}
const AccumulateElite := {
	"canonical_name": "AccumulateElite",
	"name": "Repressed foreboding",
	"description": "{artifact_name}: Increase your repressed Foreboding."\
			+ "Increase max {anxiety} by {anxiety_amount}",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.OVERWORLD,
	"rarity": "Common",
	"amounts": {
		"pathos_avg_multiplier": 4,
		"anxiety_amount": 7
	},
}
const AccumulateArtifact := {
	"canonical_name": "AccumulateArtifact",
	"name": "Repressed desire",
	"description": "{artifact_name}: Increase your repressed Desire",
	"icon": preload("res://assets/icons/artifacts/Repressed Desire.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Common",
	"amounts": {
		"pathos_avg_multiplier": 4,
	},
}

const PowerHeal := {
	"canonical_name": "PowerHeal",
	"name": "White noise machine",
	"description": "{artifact_name}: Whenever you play a {power_card}, {relax} for {healing_amount}.",
	"icon": preload("res://assets/icons/artifacts/nested-hearts.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Rare",
	"amounts": {
		"healing_amount": 2
	},
	"linked_terms": [
		"relax",
	],
}

const PerturbationHeal := {
	"canonical_name": "PerturbationHeal",
	"name": "A taste for liquorice",
	"description": "{artifact_name}: At the start of each Ordeal, {relax} for {heal_amount} per {condition_card} in your draw pile.",
	"icon": preload("res://assets/icons/artifacts/pretzel.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"heal_amount": 1
	},
	"linked_terms": [
		"relax",
	],
}

const ImproveImpervious := {
	"canonical_name": "ImproveImpervious",
	"name": "Pet eel",
	"description": "{artifact_name}: {impervious} {stress} reduction on the dreamer is increased by 3% per stack.",
	"icon": preload("res://assets/icons/artifacts/Pet Eel.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"per_stack_modifier": 0.03
	},
	"linked_terms": [
		"impervious",
	],
}

const ImproveFortify := {
	"canonical_name": "ImproveFortify",
	"name": "Ataraxia",
	"description": "{artifact_name}: Whenever you lose {fortify}, gain that twice that many stacks {armor}.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"linked_terms": [
		"fortify",
		"armor",
	],
}

const PorcelainDoll := {
	"canonical_name": "PorcelainDoll",
	"name": "Porcelain doll",
	"description": "{colour} {artifact_name} ({progress}): The next {threshold} {card_type} cards you gain, are used to finish colouring the doll.",
	"icon": preload("res://assets/icons/artifacts/person.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Encounter",
}

const RedWave := {
	"canonical_name": "RedWave",
	"name": "Inquisite vibes",
	"description": "{artifact_name}: At the start of your turn, if your hand has {threshold}+ {attack_card} cards, gain {defence_amount} {defence}",
	"icon": preload("res://assets/icons/artifacts/waves_red.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"threshold": 4,
		"defence_amount": 8
	},
	"linked_terms": [
		"defence",
	],
}

const BlueWave := {
	"canonical_name": "BlueWave",
	"name": "Cool vibes",
	"description": "{artifact_name}: At the start of your turn, if your hand has {threshold}+ {skill_card} cards, {attack} all Torments for {damage_amount}.",
	"icon": preload("res://assets/icons/artifacts/waves_blue.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"threshold": 4,
		"damage_amount": 5
	},
	"linked_terms": [
		"attack",
	],
}

const PurpleWave := {
	"canonical_name": "PurpleWave",
	"name": "Chill vibes",
	"description": "{artifact_name}: At the start of your turn, if your hand has {threshold}+ {understanding_card} cards, {relax} for {heal_amount}.",
	"icon": preload("res://assets/icons/artifacts/waves_purple.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"threshold": 3,
		"heal_amount": 4,
	},
	"linked_terms": [
		"relax",
	],
}

const ProgressiveImmersion := {
	"canonical_name": "ProgressiveImmersion",
	"name": "Glass tower",
	"description": "{artifact_name}: You have {immersion_amount} extra {energy} per turn.\n"\
			+ "You cannot progress cards by playing them during ordeals anymore.",
	"icon": GENERIC_BOSS_ARTIFACT_ICON,
	"context": EffectContext.BATTLE,
	"rarity": "Boss",
	"amounts": {
		"immersion_amount": 1,
	},
	"linked_terms": [
		"energy",
	],
}

const BossCardDraw := {
	"canonical_name": "BossCardDraw",
	"name": "Squishy brain toy",
	"description": "{artifact_name}: Draw {draw_amount} card at the start of each turn",
	"icon": GENERIC_BOSS_ARTIFACT_ICON,
	"context": EffectContext.BATTLE,
	"rarity": "Boss",
	"amounts": {
		"draw_amount": 1,
	},
}

const RandomUpgrades := {
	"canonical_name": "RandomUpgrades",
	"name": "20-sided die",
	"description": "{artifact_name}: You have {immersion_amount} extra {energy} per turn.\n"\
			+ "Your card upgrades are chosen randomly.",
	"icon": preload("res://assets/icons/artifacts/dice-twenty-faces-twenty.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Boss",
	"amounts": {
		"immersion_amount": 1,
	},
	"linked_terms": [
		"energy",
	],
}

const BetterRareChance := {
	"canonical_name": "BetterRareChance",
	"name": "The gruyere of insight",
	"description": "{artifact_name}: Your chance of finding Rare cards is doubled.",
	"icon": preload("res://assets/icons/artifacts/cheese-wedge.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Encounter",
	"amounts": {
		"rare_multiplier": 2,
	},
}

const BossDraft := {
	"canonical_name": "BossDraft",
	"name": "Cool draft beer",
	"description": "{artifact_name}: Choose one of your archetypes. "\
			+ "Get {draft_amount} card draft choices from it. They all start with {progress_amount} progress.",
	"icon": preload("res://assets/icons/artifacts/beer-stein.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Boss",
	"amounts": {
		"draft_amount": 5,
		"progress_amount": 4,
	},
}

const FreeCard := {
	"canonical_name": "FreeCard",
	"name": "A nice warm meal",
	"description": "{artifact_name}: A random card in your deck, costing 1 or more {energy}, becomes free.",
	"icon": preload("res://assets/icons/artifacts/camp-cooking-pot.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Common",
	"linked_terms": [
		"energy",
	],
}

const AddAlphaTag := {
	"canonical_name": "AddAlphaTag",
	"name": "Crystal ball",
	"description": "{artifact_name}: Choose a card in your deck. It gains {alpha}.",
	"icon": preload("res://assets/icons/artifacts/crystal-ball.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Uncommon",
	"linked_terms": [
		"alpha",
	],
}

const AddOmegaTag := {
	"canonical_name": "AddOmegaTag",
	"name": "Jigsaw piece",
	"description": "{artifact_name}: Choose a card in your deck. It gains {omega}.",
	"icon": preload("res://assets/icons/artifacts/jigsaw-piece.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Uncommon",
	"linked_terms": [
		"omega",
	],
}

const AddFrozenTag := {
	"canonical_name": "AddFrozenTag",
	"name": "Earworm",
	"description": "{artifact_name}: Choose a card in your deck. It gains {frozen}.",
	"icon": preload("res://assets/icons/artifacts/leeching-worm.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Rare",
	"linked_terms": [
		"frozen",
	],
}

const IncreaseRandomDamage := {
	"canonical_name": "IncreaseRandomDamage",
	"name": "Masterwork looking glass",
	"description": "{artifact_name}: A random card doing {attack} in your deck, will increase its {attack} by 1.",
	"icon": preload("res://assets/icons/artifacts/Masterwork Looking Glass.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Common",
	"linked_terms": [
		"attack",
	],
}

const IncreaseRandomDefence := {
	"canonical_name": "IncreaseRandomDefence",
	"name": "Fancy nail coat",
	"description": "{artifact_name}: A random card giving {defence} in your deck, will increase its {defence} by 1.",
	"icon": preload("res://assets/icons/artifacts/Fancy Nail Coat.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Common",
	"linked_terms": [
		"defence",
	],
}

const IncreaseConfusionStacks := {
	"canonical_name": "IncreaseConfusionStacks",
	"name": "Smoke bomb",
	"description": "{artifact_name}: Choose a {disempower} card in your deck. Increase the amount of {disempower} stacks it is applying by 1.",
	"icon": preload("res://assets/icons/artifacts/smoke-bomb.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Uncommon",
	"linked_terms": [
		"disempower",
	],
}

const IncreaseImmersionGain := {
	"canonical_name": "IncreaseImmersionGain",
	"name": "Bookmark",
	"description": "{artifact_name}: Choose an {energy} card in your deck. Increase the amount of {energy} it is providing by 1.",
	"icon": preload("res://assets/icons/artifacts/bookmark.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Rare",
	"linked_terms": [
		"energy",
	],
}

const BetterArtifactChance := {
	"canonical_name": "BetterArtifactChance",
	"name": "Supportive plushie",
	"description": "{artifact_name}: The quality of the curios your find is increased.",
	"icon": preload("res://assets/icons/artifacts/Supportive Plushie.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Encounter",
	"amounts": {
		"uncommon_multiplier": 1.5,
		"rare_multiplier": 3,
	},
}


const StartingDisempower := {
	"canonical_name": "StartingDisempower",
	"name": "Ouroboros",
	"description": "{artifact_name}: At the start of each Ordeal, apply {effect_stacks} {disempower} to all Torments.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.BATTLE,
	"rarity": "Encounter",
	"amounts": {
		"effect_stacks": 1
	},
	"linked_terms": [
		"disempower",
	],
}

const StartingVulnerable := {
	"canonical_name": "StartingVulnerable",
	"name": "Sisyphean task",
	"description": "{artifact_name}: At the start of each Ordeal, apply {effect_stacks} {vulnerable} to all Torments.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"effect_stacks": 2
	},
	"linked_terms": [
		"vulnerable",
	],
}

const ProgressEverything := {
	"canonical_name": "ProgressEverything",
	"name": "Tortoise shell",
	"description": "{artifact_name}: All cards added to your deck receive {progress_amount} progress.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.OVERWORLD,
	"rarity": "Uncommon",
	"amounts": {
		"progress_amount": 8
	},
}

const IncreaseBufferStacks := {
	"canonical_name": "IncreaseBufferStacks",
	"name": "A drop of honey",
	"description": "{artifact_name}: Choose a {buffer} card in your deck. Increase the amount of {buffer} stacks it is providing by 1.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.OVERWORLD,
	"rarity": "Uncommon",
	"linked_terms": [
		"buffer",
	],
}

const IncreasePoisonStacks := {
	"canonical_name": "IncreasePoisonStacks",
	"name": "A candle in the dark",
	"description": "{artifact_name}: Choose a {doubt} card in your deck. Increase the amount of {doubt} stacks it is providing by 1.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.OVERWORLD,
	"rarity": "Uncommon",
	"linked_terms": [
		"poison",
	],
}

const DecreaseExertStacks := {
	"canonical_name": "DecreaseExertStacks",
	"name": "Ray of hope",
	"description": "{artifact_name}: Choose a {exert} card in your deck. Decrease the amount of {player_health} it is giving by 2.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.OVERWORLD,
	"rarity": "Uncommon",
	"linked_terms": [
		"player_health",
	],
}

const DoubleFirstStartup := {
	"canonical_name": "DoubleFirstStartup",
	"name": "Birthday gift",
	"description": "{artifact_name}: One random {startup} effect is triggered twice.",
	"icon": preload("res://assets/icons/artifacts/Birthday Gift.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"linked_terms": [
		"startup",
	],
}

const StrengthenUp := {
	"canonical_name": "StrengthenUp",
	"name": "Buddha figurine",
	"description": "{artifact_name}: You can gain {strengthen} during deep torpor.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.BATTLE,
	"rarity": "Rare",
	"amount": 0,
	"max_uses": 3,
	"linked_terms": [
		"strengthen",
	],
}

const QuickenUp := {
	"canonical_name": "QuickenUp",
	"name": "Chess set",
	"description": "{artifact_name}: You can gain {quicken} during deep torpor.",
	"icon": preload("res://assets/icons/artifacts/empty-chessboard.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Rare",
	"amount": 0,
	"max_uses": 3,
	"linked_terms": [
		"quicken",
	],
}

const EnhanceOnRest := {
	"canonical_name": "EnhanceOnRest",
	"name": "Dream catcher",
	"description": "{artifact_name}: You can enhance cards during deep torpor.",
	"icon": preload("res://assets/icons/artifacts/dream-catcher.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Rare",
	"amount": 0,
	"max_uses": 3,
	"linked_terms": [
		"enhance",
	],
}

const UpgradeMemoryOnRest := {
	"canonical_name": "UpgradeMemoryOnRest",
	"name": "Portable photo camera",
	"description": "{artifact_name}: You can upgrade your memories during deep torpor.",
	"icon": preload("res://assets/icons/artifacts/photo-camera.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Uncommon",
	"amount": 0,
	"max_uses": 3,
}

const ReduceCurioRerollPerturbChance := { # TODO: Tests
	"canonical_name": "ReduceCurioRerollPerturbChance",
	"name": "Shamrock",
	"description": "{artifact_name}: Reduces the chance to get a {condition_card} when rerolling a Desire curio.",
	"icon": preload("res://assets/icons/artifacts/shamrock.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Common",
	"amounts": {
		"chance_multiplier": 0.6,
	},
}

const IncreaseUpgradedDraftChance := { # TODO: Tests
	"canonical_name": "IncreaseUpgradedDraftChance",
	"name": "Ancient literature",
	"description": "{artifact_name}: Increases the chance to find an upgraded card when drafting cards.",
	"icon": preload("res://assets/icons/artifacts/Ancient Literature.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Uncommon",
	"amounts": {
		"chance_multiplier": 1.25,
	},
}

const NoRest := {
	"canonical_name": "NoRest",
	"name": "Moka pot",
	"description": "{artifact_name}: You have {immersion_amount} extra {energy} per turn.\n"\
			+ "You cannot rest during deep torpor anymore.",
	"icon": preload("res://assets/icons/artifacts/moka-pot.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Boss",
	"amounts": {
		"immersion_amount": 1,
	},
	"linked_terms": [
		"energy",
	],
}

const SmallerDrafts := {
	"canonical_name": "SmallerDrafts",
	"name": "The acquiescent void",
	"description": "{artifact_name}: You have {immersion_amount} extra {immersion} per turn.\n"\
			+ "Your choice of cards to draft is reduced by 2 (min 1).",
	"icon": GENERIC_BOSS_ARTIFACT_ICON,
	"context": EffectContext.BATTLE,
	"rarity": "Boss",
	"amounts": {
		"immersion_amount": 1,
		"card_draft_modifier": -2,
	},
	"linked_terms": [
		"energy",
	],
}


const BirdHouse := {
	"canonical_name": "BirdHouse",
	"name": "Bird house",
	"description": "{artifact_name}: Gain or upgrade one random memory\n"\
			+ "Gain {draft_amount} card\n"\
			+ "Gain {pathos_masteries} pathos masteries\n"\
			+ "Gain {health_amount} max {anxiety}\n"\
			+ "Progress the card requiring the most progress by {progress_amount}\n",
	"icon": preload("res://assets/icons/artifacts/bird-house.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Boss",
	"amounts": {
		"draft_amount": 1,
		"draft_choices": 5,
		"pathos_masteries": 5,
		"memory_amount": 1,
		"memory_upgrade_amount": 2,
		"health_amount": 5,
		"progress_amount": 10,
	},
}

const LimitMaxExert := {
	"canonical_name": "LimitMaxExert",
	"name": "A silver lining",
	"description": "{artifact_name}: If you've taken at least {exert_amount} during your turn, {exert} cards do not give {anxiety} anymore.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"exert_amount": 10,
	},
}

const ConstantImpervious := {
	"canonical_name": "ConstantImpervious",
	"name": "Golden feather",
	"description": "{artifact_name}: At the start of each turn, gain {effect_stacks} {impervious}",
	"icon": preload("res://assets/icons/artifacts/Golden Feather.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Rare",
	"amounts": {
		"effect_stacks": 1,
	},
	"linked_terms": [
		"impervious",
	],
}


const StartingFortify := {
	"canonical_name": "StartingFortify",
	"name": "Epic beard",
	"description": "{artifact_name}: At the start of each ordeal, gain {effect_stacks} {fortify}.",
	"icon": preload("res://assets/icons/artifacts/beard.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"effect_stacks": 1,
	},
	"linked_terms": [
		"fortify",
	],
}

const ThickHeal := {
	"canonical_name": "ThickHeal",
	"name": "Fluffy pillow",
	"description": "{artifact_name}: Every turn, {relax} for {heal_amount}. Every time you reshuffle your deck, take {exert_amount} {player_health}.",
	"icon": preload("res://assets/icons/artifacts/Fluffy Pillow.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"heal_amount": 1,
		"exert_amount": 3,
	},
	"linked_terms": [
		"relax",
		"player_health",
	],
}

const DoubleProgress := {
	"canonical_name": "DoubleProgress",
	"name": "Search engine",
	"description": "{artifact_name}: If your deck has {card_amount} or more cards, your card progression in ordeals is doubled.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"card_amount": 25,
	},
}


const ThickDeckRareChance := {
	"canonical_name": "ThickDeckRareChance",
	"name": "Muumuu",
	"description": "{artifact_name}: If your deck has {card_amount} or more cards, your chance of finding Rare cards is doubled.",
	"icon": preload("res://assets/icons/artifacts/Muumuu.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Common",
	"amounts": {
		"rare_multiplier": 2,
		"card_amount": 25,
	},
}

const MoreShopMasteries := {
	"canonical_name": "MoreShopMasteries",
	"name": "Passionate loneliness",
	"description": "{artifact_name}: Whenever you visit the shop, gain {masteries_amount} {pathos} masteries.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.OVERWORLD,
	"rarity": "Encounter",
	"amounts": {
		"masteries_amount": round(Pathos.MASTERY_BASELINE * 0.6),
	},
}


const MoreArtifactMasteries := {
	"canonical_name": "MoreArtifactMasteries",
	"name": "Passionate desire",
	"description": "{artifact_name}: Whenever you find a curio, gain {masteries_amount} {pathos} masteries.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.OVERWORLD,
	"rarity": "Encounter",
	"amounts": {
		"masteries_amount": round(Pathos.MASTERY_BASELINE),
	},
}

const MoreRestMasteries := {
	"canonical_name": "MoreRestMasteries",
	"name": "Passionate lethargy",
	"description": "{artifact_name}: Whenever you fall in deep torpor, gain {masteries_amount} {pathos} masteries.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.OVERWORLD,
	"rarity": "Encounter",
	"amounts": {
		"masteries_amount": round(Pathos.MASTERY_BASELINE * 0.6),
	},
}

const MoreEliteMasteries := {
	"canonical_name": "MoreEliteMasteries",
	"name": "Passionate foreboding",
	"description": "{artifact_name}: Whenever you encounter an elite torment, gain {masteries_amount} {pathos} masteries.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.OVERWORLD,
	"rarity": "Encounter",
	"amounts": {
		"masteries_amount": round(Pathos.MASTERY_BASELINE * 2),
	},
}

const MoreNCEMasteries := {
	"canonical_name": "MoreNCEMasteries",
	"name": "Passionate curiosity",
	"description": "{artifact_name}: Whenever you encounter a non-ordeal encounter, gain {masteries_amount} {pathos} masteries.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.OVERWORLD,
	"rarity": "Encounter",
	"amounts": {
		"masteries_amount": round(Pathos.MASTERY_BASELINE),
	},
}

const MoreEnemyMasteries := {
	"canonical_name": "MoreEnemyMasteries",
	"name": "Passionate frustration",
	"description": "{artifact_name}: Whenever you encounter a normal torment encounter, gain {masteries_amount} {pathos} mastery.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.OVERWORLD,
	"rarity": "Encounter",
	"amounts": {
		"masteries_amount": round(Pathos.MASTERY_BASELINE * 0.3),
	},
}

const LightningMarble := {
	"canonical_name": "LightningMarble",
	"name": "Lightning marble",
	"description": "{artifact_name}: At the end of each turn turn, {attack} one random Torment for {damage_amount}.",
	"icon": preload("res://assets/icons/artifacts/Lightning Marble.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"damage_amount": 3,
	},
}


const DoubleFusion := {
	"canonical_name": "DoubleFusion",
	"name": "Replicator",
	"description": "{artifact_name}: Whenever you draft a fusion card, gain an extra copy.",
	"icon": preload("res://assets/icons/artifacts/tumor.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Rare",
}


const ThickThorns := {
	"canonical_name": "ThickThorns",
	"name": "Black rose",
	"description": "{artifact_name}: At that start of each Ordeal turn, gain {effect_stacks} {thorns}. "\
		+ "Lose {detrimental_integer} {thorns} whenever your deck is reshuffled.",
	"icon": preload("res://assets/icons/artifacts/Black Rose.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Rare",
	"amounts": {
		"effect_stacks": 2,
		"detrimental_integer": 4,
	},
	"linked_terms": [
		Terms.ACTIVE_EFFECTS.thorns.name,
	],
}


const ThickBoss := {
	"canonical_name": "ThickBoss",
	"name": "Buddha figurine",
	"description": "{artifact_name}: You have {immersion_amount} extra {energy} per turn.\n"\
			+ "At the start of each ordeal, add a number of Perturbations in your discard pile until your deck size is {min_deck_size}",
	"icon": preload("res://assets/icons/artifacts/Buddha Figurine.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Boss",
	"amounts": {
		"min_deck_size": 30,
		"immersion_amount": 1,
	},
	"linked_terms": [
		"energy",
	],
}


const NoChoice := { # TODO: Tests
	"canonical_name": "NoChoice",
	"name": "Funky compass",
	"description": "{artifact_name}: You have {immersion_amount} extra {energy} per turn.\n"\
			+ "You only ever get 1 choice for each journal page",
	"icon": preload("res://assets/icons/artifacts/Funky Compass.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Boss",
	"amounts": {
		"immersion_amount": 1,
	},
	"linked_terms": [
		"energy",
	],
}


const CostlyUpgrades := {
	"canonical_name": "CostlyUpgrades",
	"name": "Gilded cage",
	"description": "{artifact_name}: You have {immersion_amount} extra {energy} per turn.\n"\
			+ "Reduce the amount of masteries gained from torment encounters by 30%",
	"icon": preload("res://assets/icons/artifacts/Mnemonic Ritual.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Boss",
	"amounts": {
		"immersion_amount": 1,
		"masteries_modifier": -0.3,
	},
	"linked_terms": [
		"energy",
	],
}

const NoSmith := { # TODO: Tests
	"canonical_name": "NoSmith",
	"name": "Espresso machine",
	"description": "{artifact_name}: You have {immersion_amount} extra {energy} per turn.\n"\
			+ "You cannot progress cards during deep torpor anymore.",
	"icon": preload("res://assets/icons/artifacts/moka-pot.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Boss",
	"amounts": {
		"immersion_amount": 1,
	},
	"linked_terms": [
		"energy",
	],
}

const CursedCurios := { # TODO: Tests
	"canonical_name": "CursedCurios",
	"name": "A dirty mind",
	"description": "{artifact_name}: You have {immersion_amount} extra {energy} per turn.\n"\
			+ "All recalled curios, always give 1 extra {perturbation}",
	"icon": GENERIC_BOSS_ARTIFACT_ICON,
	"context": EffectContext.BATTLE,
	"rarity": "Boss",
	"amounts": {
		"immersion_amount": 1,
		"chance_multiplier": 2,
	},
	"linked_terms": [
		"energy",
	],
}

const SavedForgets := {
	"canonical_name": "SavedForgets",
	"name": "Mnemonic ritual",
	"description": "{artifact_name}: The first time you {forget} a card in an ordeal, \n"\
			+ "it is discarded instead.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.BATTLE,
	"rarity": "Starting",
	"amounts": {},
	"linked_terms": [
		"forget",
	],
}


const StartingStartup := {
	"canonical_name": "StartingStartup",
	"name": "Globe of the dawn",
	"description": "{artifact_name}: At the start of each ordeal, shuffle {card_amount} random {startup} cards to your draw pile.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"card_amount": 1,
	},
	"linked_terms": [
		"startup",
	],
}

const StartupDraw := {
	"canonical_name": "StartupDraw",
	"name": "Orb of the dusk",
	"description": "{artifact_name}: Every time you play a {startup} card, draw {draw_amount} card.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"draw_amount": 1
	},
	"linked_terms": [
		"startup",
	],
}


const RandomForgottenCards := {
	"canonical_name": "RandomForgottenCards",
	"name": "The hat of ideas",
	"description": "{artifact_name}: Every time you {forget} a card, spawn {card_amount} random card in your hand.",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.BATTLE,
	"rarity": "Rare",
	"amounts": {
		"card_amount": 1
	},
	"linked_terms": [
		"forget",
	],
}


const WeakerElites := {
	"canonical_name": "WeakerElites",
	"name": "Weaker Elites",
	"description": "{artifact_name}: Foreboding Torments have {health_reduction}% less {comprehension}",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"health_reduction": 25
	},
	"linked_terms": [
		"comprehension",
	],
}


const ConstantMark := {
	"canonical_name": "ConstantMark",
	"name": "Constant Spotlight",
	"description": "{artifact_name}: At the start of each turn, apply {effect_stacks} {marked} to a random torment",
	"icon": GENERIC_ARTIFACT_ICON,
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"effect_stacks": 1
	},
	"linked_terms": [
		"marked",
	],
}

const ImproveArmor := {
	"canonical_name": "ImproveArmor",
	"name": "White lotus",
	"description": "{artifact_name}: Your {armor} starts decreasing only after {threshold_amount} stacks.",
	"icon": preload("res://assets/icons/artifacts/rose.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"threshold_amount": 3
	},
	"linked_terms": [
		"armor",
	],
}

const SwiftPerturbations := {
	"canonical_name": "SwiftPerturbations",
	"name": "Swift Perturbations",
	"description": "{artifact_name}: Whenever you draw a {perturbation}, draw {draw_amount} card",
	"icon": preload("res://assets/icons/artifacts/rose.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"draw_amount": 1
	},
	"linked_terms": [
		"perturbation",
		"swift",
	],
}

const HealThickDecks := {
	"canonical_name": "HealThickDecks",
	"name": "Tiny Hammock",
	"description": "{artifact_name}: Whenever you add a card to your deck, {relax} for {heal_amount}",
	"icon": preload("res://assets/icons/artifacts/rose.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Common",
	"amounts": {
		"heal_amount": 5
	},
	"linked_terms": [
		"relax",
	],
}

const BufferedSpawns := {
	"canonical_name": "BufferedSpawns",
	"name": "Swift Perturbations",
	"description": "{artifact_name}: Whenever any card is spawned in the game during an ordeal, gain {effect_stacks} {buffer}",
	"icon": preload("res://assets/icons/artifacts/rose.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"effect_stacks": 1
	},
	"linked_terms": [
		"buffer",
	],
}




## TODO: Artifact which increases chance to find Fusion cards
## TODO. Scipt base doesn't exist yet
#const DoubleMemory := {
#	"canonical_name": "DoubleMemory",
#	"name": "Memento",
#	"description": "{artifact_name}: Double the effect of a random memory",
#	"icon": GENERIC_ARTIFACT_ICON,
#	"context": EffectContext.OVERWORLD,
#	"rarity": "Rare",
#}

# Generic artifacts which have a chance to appear in any playthrough
const GENERIC := [
	StartingHeal,
	StartingStrength,
	StartingConfidence,
	StartingCards,
	StartingImmersion,
	FirstPowerAttack,
	AccumulateEnemy,
	AccumulateRest,
	AccumulateNCE,
	AccumulateShop,
	AccumulateElite,
	AccumulateArtifact,
	MaxHealth,
	RepressedEnemyBuff,
	ThickExplosion,
	ThickImmersion,
	ThickStrength,
	ThinCardDraw,
	UpgradedAction,
	UpgradedControl,
	UpgradedUnderstanding,
	UpgradedConcentration,
	ResistPoison,
	ResistBurn,
	ResistDisempower,
	ResistVulnerable,
	PowerHeal,
	RedWave,
	BlueWave,
	PurpleWave,
	FreeCard,
	AddAlphaTag,
	AddOmegaTag,
	AddFrozenTag,
	IncreaseRandomDamage,
	IncreaseRandomDefence,
	StartingVulnerable,
	StrengthenUp,
	QuickenUp,
	EnhanceOnRest,
	UpgradeMemoryOnRest,
	ReduceCurioRerollPerturbChance,
	IncreaseUpgradedDraftChance,
	ThickHeal,
	DoubleProgress,
	ThickDeckRareChance,
	LightningMarble,
	ThickThorns,
	WeakerElites,
	ConstantMark,
	SwiftPerturbations,
	HealThickDecks,
]

# Archetype-specific artifacts which only appear in runs in which
# their tied archetype is selected.
const ARCHETYPE := [
	EndingHeal,
	SavedForgets,
]

# Artifact-specific artifacts which only appear in runs which
# an archetype with that specific tag is used
const TAG := {
	Terms.ACTIVE_EFFECTS.thorns.name: [
		ImproveThorns,
		StartingThorns,
	],
	Terms.ACTIVE_EFFECTS.poison.name: [
		ImprovePoison,
		IncreasePoisonStacks,
	],
	Terms.ACTIVE_EFFECTS.burn.name: [
		ImproveBurn,
	],
	Terms.ACTIVE_EFFECTS.impervious.name: [
		ImproveImpervious,
		ConstantImpervious,
	],
	Terms.ACTIVE_EFFECTS.fortify.name: [
		ImproveFortify,
		StartingFortify,
	],
	Terms.ACTIVE_EFFECTS.armor.name: [
		ImproveArmor,
	],
	Terms.ACTIVE_EFFECTS.disempower.name: [
		IncreaseConfusionStacks,
	],
	Terms.ACTIVE_EFFECTS.buffer.name: [
		IncreaseBufferStacks,
	],
	Terms.GENERIC_TAGS.purpose.name: [
		IncreaseImmersionGain,
	],
	Terms.GENERIC_TAGS.startup.name: [
		DoubleFirstStartup,
		StartingStartup,
		StartupDraw,
	],
	Terms.GENERIC_TAGS.fusion.name: [
		DoubleFusion,
	],
	Terms.GENERIC_TAGS.exert.name: [
		DecreaseExertStacks,
		LimitMaxExert,
	],
	Terms.GENERIC_TAGS.slumber.name: [
		RandomForgottenCards,
	],
	Terms.GENERIC_TAGS.spawn.name: [
		BufferedSpawns
	],
}

# These artifacts are only found in non-combat encounters
const ENCOUNTER := [
	PorcelainDoll,
	BetterRareChance,
	BetterArtifactChance,
	PerturbationHeal,
	StartingDisempower,
	ProgressEverything,
	MoreShopMasteries,
	MoreArtifactMasteries,
	MoreRestMasteries,
	MoreEnemyMasteries,
	MoreEliteMasteries,
	MoreNCEMasteries,
]

const BOSS := [
	ProgressiveImmersion,
	RandomUpgrades,
	BossCardDraw,
	BossDraft,
	NoRest,
	SmallerDrafts,
	BirdHouse,
	ThickBoss,
	NoChoice,
	CostlyUpgrades,
	NoSmith,
	CursedCurios,
]


# Takes as arguments the purpose of artifacts to return. Generic, Shop or Boss
# Each purpose returns a slightly different format dictionary
# Also gets a list of archetypes tied to the current archetypes and merges them into
# The generic ones to return a common list
# Finally a list of artifacts to exclude can be passes
# Those would typically be artifacts already owned, or seen
static func get_organized_artifacts(
	purpose := "generic",
	archetype_artifacts := [],
	excluded_artifacts := []) -> Dictionary:
	var ret_dict := {}
	match purpose:
		"generic":
			for rarity in ["Common", "Uncommon", "Rare"]:
				ret_dict[rarity] = []
				for artifact in GENERIC + archetype_artifacts:
					if artifact.rarity == rarity\
							and not artifact.canonical_name in excluded_artifacts:
						ret_dict[rarity].append(artifact)
		"boss":
			ret_dict["Boss"] = []
			for artifact in BOSS:
				if artifact.rarity == "Boss"\
						and not artifact.canonical_name in excluded_artifacts:
					ret_dict["Boss"].append(artifact)
	return(ret_dict)

static func get_artifact_bbcode_format(artifact_definition: Dictionary) -> Dictionary:
	var format := {}
	format['artifact_name'] = artifact_definition.name
	for key in artifact_definition.get('amounts', {}):
		format[key] = artifact_definition.amounts[key]
	return(format)

static func get_complete_artifacts_array() -> Array:
	var tag_artifacts := []
	for tag in TAG:
		tag_artifacts += TAG[tag]
	return(GENERIC + ARCHETYPE + ENCOUNTER + BOSS + tag_artifacts)

static func find_artifact_from_canonical_name(artifact_canonical_name: String):
	for artifact_def in get_complete_artifacts_array():
		if artifact_def.canonical_name == artifact_canonical_name:
			return(artifact_def)

static func find_artifact_from_name(artifact_name: String):
	for artifact_def in get_complete_artifacts_array():
		if artifact_def.name == artifact_name:
			return(artifact_def)

static func artifact_exists(artifact_name: String) -> bool:
	if find_artifact_from_canonical_name(artifact_name):
		return(true)
	return(false)
