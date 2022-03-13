class_name NonCombatEncounter
extends SingleEncounter

const NCE_META_DICT := {
	"name": '',
	"meta_type": "nce",
}
const NCE_POPUP_DICT := {
	"name": '',
	"meta_type": "popup_card",
}
const NCE_CARD_ENTRY_POPUP_DICT := {
	"name": '',
	"meta_type": "popup_card_entry",
}
const ARTIFACT_POPUP_DICT := {
	"name": '',
	"meta_type": "popup_artifact",
}


var reward_description: String

func _init() -> void:
	pathos_released = Terms.RUN_ACCUMULATION_NAMES.nce


func get_meta_hover_description(_meta_tag: String) -> String:
	return('')


# 'card' can be either a card name string, or a CardEntry
func _prepare_card_popup_bbcode(card, url_text: String) -> String:
	var popup_tag :Dictionary= NCE_POPUP_DICT.duplicate(true)
	if typeof(card) == TYPE_STRING:
		popup_tag = NCE_POPUP_DICT.duplicate(true)
		popup_tag["name"] = card
		globals.journal.prepare_popup_card(card)
	else:
		popup_tag = NCE_CARD_ENTRY_POPUP_DICT.duplicate(true)
		popup_tag["name"] = card.get_instance_id()
		globals.journal.prepare_popup_card(card)
	var url_bbcode := "[url=%s]%s[/url]" % [JSON.print(popup_tag), url_text]
	return(url_bbcode)

# This also handles memories
func _prepare_artifact_popup_bbcode(artifact_name: String, url_text: String) -> String:
	var popup_tag = ARTIFACT_POPUP_DICT.duplicate(true)
	popup_tag["name"] = artifact_name
	var url_bbcode := "[url=%s]%s[/url]" % [JSON.print(popup_tag), url_text]
	globals.journal.prepare_popup_artifact(artifact_name)
	return(url_bbcode)
 
func _prepare_secondary_choices(secondary_choices: Dictionary, scformat: Dictionary, disabled_choices := []) -> void:
	for c in secondary_choices:
		secondary_choices[c] = secondary_choices[c].format(scformat).format(Terms.get_bbcode_formats(18))
	for choice in disabled_choices:
		secondary_choices[choice] = "[color=red]" + secondary_choices[choice] + "[/color]"	
	globals.journal.add_nested_choices(secondary_choices, disabled_choices)
