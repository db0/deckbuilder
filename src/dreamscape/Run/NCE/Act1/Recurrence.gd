# Gives three choices, paid with released pathos to get some rewards

extends SurpriseEncounter


const RECURRENCE_ELITE = {
	"scene": preload("res://src/dreamscape/CombatElements/Enemies/Elites/Recurrence.tscn")
}

var difficulties := {
	"Early Night": "easy",
	Act2.get_act_name(): "medium",
}

var memory_prep: MemoryPrep


func _init():
	description = "I recognised the sound. Cracking bark but somehow wet. It made me feel ill hearing it and each snap left a lingering, ghastly anticipation. Not bark...bones. Cracking bones. No...not again..."


func begin() -> void:
	.begin()
	surprise_combat_encounter = SurpriseCombatEncounter.new(
			RECURRENCE_ELITE, 
			difficulties[globals.encounters.current_act.get_act_name()], 
			self)
	surprise_combat_encounter.start_ordeal()


func end() -> void:
	surprise_combat_encounter.finish_surpise_ordeal()
	.end()
	memory_prep = MemoryPrep.new(2, true)
	for memory in memory_prep.selected_memories:
		var existing_memory = globals.player.find_memory(memory.canonical_name)
		if existing_memory:
			existing_memory.upgrade()
			existing_memory.upgrade()
		else:
			globals.player.add_memory(memory.canonical_name)
	var reward_text = '[url={"name": "memory1","meta_type": "nce"}]I have seen this[/url] before. I know this. Overcoming this recurrence [url={"name": "memory2","meta_type": "nce"}]jolted my memories[/url].'
	globals.journal.display_nce_rewards(reward_text)


func get_meta_hover_description(meta_tag: String) -> String:
	match meta_tag:
		"memory1":
			var bbformat1 = memory_prep.selected_memories[0]["bbformat"]
			return("[img=18x18]{icon}[/img] {description}.".format(bbformat1))
		"memory2":
			var bbformat2 = memory_prep.selected_memories[1]["bbformat"]
			return("[img=18x18]{icon}[/img] {description}.".format(bbformat2))
		_:
			return('')
