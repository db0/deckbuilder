class_name ArtifactObject
extends Reference

const ARTIFACT_SCENE = preload("res://src/dreamscape/Artifacts/ArtifactTemplate.tscn")

signal removed
signal counter_modified(counter_value)

# Some artifact might need to track something. In which case we use this var.
var counter := 0 setget set_counter
var artifact_scene: PackedScene
var canonical_name: String
var definition: Dictionary
# Whether this artifact is active during the battle or the journal phases
var context: int
# These is an open ended dictionary which we can use to pass arguments to the 
# artifact definition. For example if we want the same artifact, but it behaves in
# different ways, based on how the player got it.
var modifiers := {}

func _init(artifact_name: String, _mods := {}) -> void:
	artifact_scene = ARTIFACT_SCENE
	definition = ArtifactDefinitions[artifact_name].duplicate(true)
	canonical_name = definition["canonical_name"]
	context = definition["context"]
	modifiers = _mods

func remove_self() -> void:
	emit_signal("removed")

func set_counter(value: int) -> void:
	counter = value
	emit_signal("counter_modified", counter)

func instance_artifact() -> Artifact:
	var artifact: Artifact = artifact_scene.instance()
	var script_path := "res://src/dreamscape/Artifacts/%s.gd" % [canonical_name]
	var script_exists = Directory.new()
	if script_exists.file_exists(script_path):
		var artifact_script = load(script_path)
		artifact.set_script(artifact_script)
	return(artifact)
