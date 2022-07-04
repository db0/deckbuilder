# This is just a constant which preloads all card images which are used in the game
# This is to avoid loading files during runtime and to be able to easier map filenames
# to card names.
class_name ImageLibrary
extends Reference

const FINAL_IMAGES := {
	"The Whippy-Flippy": "res://assets/cards/The Whippy-Flippy.jpg",
	"Nunclucks": "res://assets/cards/Nunclucks.jpg",
	"Keep in Mind": "res://assets/cards/Keep in Mind.jpg",
	"Pialephant": "res://assets/cards/pialephant.jpg",
	"Broken Mirror": "res://assets/cards/broken_mirror.jpg",
	"The Light Calling": "res://assets/cards/The Light Calling.jpg",
	"A Squirrel": "res://assets/cards/Squirrel.jpg",
	"I'll Show Them All": "res://assets/cards/I\'ll Show Them All.jpg",
	"Death Ray": "res://assets/cards/Death Ray.jpg",
	"Dodge": "res://assets/cards/Dodge.jpg",
	"Exhaustion": "res://assets/cards/Exhaustion.jpg",
	"Murmurs": "res://assets/cards/murmurs.jpg",
	"Boast": "res://assets/cards/boast.jpg",
	"Tenacity": "res://assets/cards/Tenacity.jpg",
}
const BETA_IMAGES := {
	"Catatonia": "res://assets/cards/Catatonia.jpg",
	"Could Be Worse": "res://assets/cards/Could Be Worse.jpg",
	"Dismissal": "res://assets/cards/Dismissal.jpg",
	"Eureka!": "res://assets/cards/Eureka!.jpg",
	"Hyperfocus": "res://assets/cards/Hyperfocus.jpg",
	"Inner Justice": "res://assets/cards/Inner Justice.jpg",
	"Interpretation": "res://assets/cards/Interpretation.jpg",
	"Is it my fault?": "res://assets/cards/Is It My Fault.jpg",
	"Lash-out": "res://assets/cards/Lash-Out.jpg",
	"Prejudice": "res://assets/cards/Prejudice.jpg",
	"Rancor": "res://assets/cards/Rancor.jpg",
	"Rapid Theorizing": "res://assets/cards/Rapid Theorizing.jpg",
	"Self-Deception": "res://assets/cards/Self-Deception.jpg",
	"The Happy Place": "res://assets/cards/The Happy Place.jpg",
	"Tolerance": "res://assets/cards/Tolerance.jpg",
	"Introspection": "res://assets/cards/Introspection.jpg",
	"Change of Mind": "res://assets/cards/Change of Mind.jpg",
	"Misunderstood": "res://assets/cards/Misunderstood.jpg",
	"Mania": "res://assets/cards/Mania.jpg",
	"Terror": "res://assets/cards/beta_eyeball.jpg",
	"Discombobulation": "res://assets/cards/beta_hands.jpg",
	"The Laughing One": "res://assets/cards/beta_smiler.jpg",
	"Confidence": "res://assets/cards/confidence.jpg",
	"Lacuna": "res://assets/cards/doodle2.jpg",
	"Unease": "res://assets/cards/doodle1.jpg",
	"Dread": "res://assets/cards/doodle3.jpg",
	"Impossible Construction": "res://assets/cards/Impossible_Construction.jpg",
	"Excogitate": "res://assets/cards/excogitate.jpg",
	"Dive-in": "res://assets/cards/Dive-in.jpg",
	"Safety of Air": "res://assets/cards/Safety of Air.jpg",
	"Nothing to Fear": "res://assets/cards/Nothing to Fear.jpg",
	"Out of Reach": "res://assets/cards/Out of Reach.jpg",
	"Confounding Movements": "res://assets/cards/Confounding Movements.jpg",
	"Noisy Whip": "res://assets/cards/Noisy Whip.jpg",
	"Whirlwind": "res://assets/cards/whirlwind.jpg",
	"Overview": "res://assets/cards/overview.jpg",
	"Rubber Eggs": "res://assets/cards/Rubber Eggs.jpg",
	"Towering Presence": "res://assets/cards/Towering Presence.jpg",
	"The Joke": "res://assets/cards/The Joke.jpg",
	"Confident Slap": "res://assets/cards/Confident Slap.jpg",
	"Ventriloquism": "res://assets/cards/Ventriloquism.jpg",
	"Cockfighting": "res://assets/cards/Cockfighting.jpg",
	"Administration": "res://assets/journal/torments/administration.jpg",
	"Vulcan": "res://assets/cards/Vulcan.jpg",
	"Vulcan2": "res://assets/cards/Vulcan2.jpg",
	"Vulcan3": "res://assets/cards/Vulcan3.jpg",
	"Universal Component": "res://assets/cards/Universal Component.jpg",
	"Photon Shield": "res://assets/cards/Photon Shield.jpg",
	"Lumen Shield": "res://assets/cards/Lumen Shield.jpg",
	"Plasma Shield": "res://assets/cards/Plasma Shield.jpg",
	"Cannon": "res://assets/cards/Cannon.jpg",
	"HiCannon": "res://assets/cards/HiCannon.jpg",
	"MegaCannon": "res://assets/cards/MegaCannon.jpg",
	"Light Jump": "res://assets/cards/Light Jump.jpg",
	"Rapid Encirclement": "res://assets/cards/Rapid Encirclement.jpg",
	"Barrel Through": "res://assets/cards/Barrel Through.jpg",
	"Find Weakness": "res://assets/cards/Find Weakness.jpg",
	"Nano-Machines": "res://assets/cards/Nano-Machines.jpg",
	"Photon Blade": "res://assets/cards/Photon Blade.jpg",
	"Fusion Grenade": "res://assets/cards/Fusion Grenade.jpg",
	"Quick Dash": "res://assets/cards/Quick Dash.jpg",
	"Charged Shot": "res://assets/cards/Charged Shot.jpg",
	"Blinding Flash": "res://assets/cards/Blinding Flash.jpg",
	"Dark Approach": "res://assets/cards/Dark Approach.jpg",
	"Dark Recovery": "res://assets/cards/Dark Recovery.jpg",
	"Widebeam": "res://assets/cards/Widebeam.jpg",
	"Spare Lens": "res://assets/cards/Spare Lens.jpg",
	"Brooding": "res://assets/cards/Brooding.jpg",
	"Recycling": "res://assets/cards/Recycling.jpg",
	"Precision": "res://assets/cards/Precision.jpg",
	"Focus Calibration": "res://assets/cards/Focus Calibration.jpg",
	"Heat Venting": "res://assets/cards/Heat Venting.jpg",
	"Streamlining": "res://assets/cards/Streamlining.jpg",
	"That's Going in the Book": "res://assets/cards/That\'s Going in the Book.jpg",
	"Note-Taking": "res://assets/cards/Note-Taking.jpg",
	"Schadenfreude": "res://assets/cards/Schadenfreude.jpg",
	"The Last Straw": "res://assets/cards/The Last Straw.jpg",
	"Memento of Anger": "res://assets/cards/Memento of Anger.jpg",
	"Memento of Safety": "res://assets/cards/Memento of Safety.jpg",
	"Moving On": "res://assets/cards/Moving On.jpg",
	"Vestige of Warmth": "res://assets/cards/Vestige of Warmth.jpg",
	"Fist of Candies": "res://assets/cards/Fist of Candies.jpg",
	"Hand of Grudge": "res://assets/cards/Hand of Grudge.jpg",
	"Vengeance": "res://assets/cards/Vengeance.jpg",
	"Reactionary": "res://assets/cards/Reactionary.jpg",
	"Nothing Forgotten": "res://assets/cards/Nothing Forgotten.jpg",
	"Stewing": "res://assets/cards/Stewing.jpg",
	"The Cold Dish": "res://assets/cards/The Cold Dish.jpg",
	"Planning": "res://assets/cards/Planning.jpg",
	"Saved for Later": "res://assets/cards/Saved for Later.jpg",
	"Reckoning Time": "res://assets/cards/Reckoning Time.jpg",
	"Prepared": "res://assets/cards/Prepared.jpg",

	# Reusing Journal Art. SHould eventually get proper illustrations
	"Stuffed Toy": "res://assets/journal/torments/stuffed_toy.jpeg",
	"Hyena": "res://assets/journal/torments/hyena.jpeg",
	"Baby": "res://assets/journal/torments/baby.jpeg",
	"Traffic Jam": "res://assets/journal/torments/traffic_jam.jpeg",
	"Gaslighter": "res://assets/journal/torments/gaslighter2.png",
	"Butterfly": "res://assets/journal/torments/butterfly.jpeg",
	"Clown": "res://assets/journal/torments/clown.jpeg",
	"Fearmonger": "res://assets/journal/torments/fearmonger.jpeg",
	"Mouse": "res://assets/journal/torments/mouse.jpeg",
	"The Critic": "res://assets/enemies/the_critic.png",
	"The Victim": "res://assets/journal/torments/the_victim.jpeg",
	"The Exam": "res://assets/journal/torments/exam.jpeg",
	"Void": "res://assets/journal/torments/void.jpeg",
	"Cringelord": "res://assets/journal/torments/cringelord.jpeg",
	"Life Path": "res://assets/journal/torments/life_path.jpeg",
	"Silent Treatment": "res://assets/journal/torments/silent_treatment.jpeg",
	"Chasm": "res://assets/journal/nce/chasm.jpeg",
	"Guilt": "res://assets/journal/torments/guilt.jpeg",
	"Nightmare": "res://assets/journal/torments/nightmare.jpeg",
	"Submerged": "res://assets/journal/torments/submerged.jpg",
	"Cockroach Infestation": "res://assets/journal/nce/cockroach.jpeg",
	"Cockroaches": "res://assets/journal/nce/cockroach.jpeg",
	"Handsy Aunt": "res://assets/journal/torments/handsy_aunt.jpeg",
	"Influencer": "res://assets/enemies/influencer.jpg",
	"Shameling": "res://assets/journal/torments/shameling.jpg",
}
