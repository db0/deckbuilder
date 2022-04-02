extends CenterContainer

onready var back_button = $"PC/VBC/Back"
onready var _total_difficulty := $"PC/VBC/TotalDifficulty"
onready var _starting_perturbations_label := $"PC/VBC/StartingPerturbations/Label"
onready var _starting_perturbations_slider := $"PC/VBC/StartingPerturbations/HSlider"
onready var _starting_perturbations_count := $"PC/VBC/StartingPerturbations/Count"
onready var _increase_progress_label := $"PC/VBC/IncreaseProgressReq/Label"
onready var _increase_progress_slider := $"PC/VBC/IncreaseProgressReq/HSlider"
onready var _increase_progress_count := $"PC/VBC/IncreaseProgressReq/Count"
onready var _act_healing_label := $"PC/VBC/ActHealing/Label"
onready var _act_healing_slider := $"PC/VBC/ActHealing/HSlider"
onready var _act_healing_count := $"PC/VBC/ActHealing/Count"
onready var _prevent_basic_card_release_checkbox := $"PC/VBC/PreventCardBasicRelease/CheckBox"
onready var _prevent_basic_card_release_count := $"PC/VBC/PreventCardBasicRelease/Count"
onready var _desire_curios_give_perturbation_checkbox := $"PC/VBC/DesireCuriosGivePerturbation/CheckBox"
onready var _desire_curios_give_perturbation_count := $"PC/VBC/DesireCuriosGivePerturbation/Count"
onready var sliders = [
	_starting_perturbations_slider,
	_increase_progress_slider,
	_act_healing_slider,
]
onready var checkboxes = [
	_prevent_basic_card_release_checkbox,
	_desire_curios_give_perturbation_checkbox,
]

func _ready() -> void:
	_total_difficulty.text = "Difficulty: " + str(globals.difficulty.total_difficulty) 
	_prevent_basic_card_release_checkbox.pressed = globals.difficulty.prevent_basic_cards_release
	_prevent_basic_card_release_count.text = str(globals.difficulty.calc_boolean_difficulty(globals.difficulty.prevent_basic_cards_release))
	_desire_curios_give_perturbation_checkbox.pressed = globals.difficulty.desire_curios_give_perturbation
	_desire_curios_give_perturbation_count.text = str(globals.difficulty.calc_boolean_difficulty(globals.difficulty.desire_curios_give_perturbation) * globals.difficulty.DIFFICULTY_MULTIPLIERS.desire_curios_give_perturbation)
	_starting_perturbations_slider.value = globals.difficulty.starting_perturbations
	_starting_perturbations_count.text = str(globals.difficulty.starting_perturbations)
	_increase_progress_slider.value = globals.difficulty.progress_increase
	_increase_progress_count.text = str(globals.difficulty.progress_increase)
	_increase_progress_slider.step = globals.difficulty.PROGRESS_INCREASE_STEP
	_act_healing_slider.value = _convert_act_healing_to_int(globals.difficulty.act_healing)
	_act_healing_count.text = str(globals.difficulty.act_healing * 100) + '%'
	for slider in sliders:
		slider.connect("value_changed", self, "_on_HSlider_value_changed", [slider])
	for checkbox in checkboxes:
		checkbox.connect("pressed", self, "_on_CheckBox_pressed", [checkbox])
	# warning-ignore:return_value_discarded
	globals.difficulty.connect("total_difficulty_recalculated", self, "_on_total_difficulty_changed")

func _on_HSlider_value_changed(value: int, slider: HSlider) -> void:
	match slider:
		_starting_perturbations_slider:
			globals.difficulty.starting_perturbations = value
			_starting_perturbations_count.text = str(value)
		_increase_progress_slider:
			globals.difficulty.progress_increase = value
			_increase_progress_count.text = str(value)
		_act_healing_slider:
			var pct := _convert_act_healing_to_pct(value)
			globals.difficulty.act_healing = pct
			_act_healing_count.text = str(pct * 100) + '%'

func _on_CheckBox_pressed(checkbox: CheckBox) -> void:
	match checkbox:
		_prevent_basic_card_release_checkbox:
			globals.difficulty.prevent_basic_cards_release = checkbox.pressed
			_prevent_basic_card_release_count.text = str(globals.difficulty.calc_boolean_difficulty(checkbox.pressed))
		_desire_curios_give_perturbation_checkbox:
			globals.difficulty.desire_curios_give_perturbation = checkbox.pressed
			_desire_curios_give_perturbation_count.text = str(globals.difficulty.calc_boolean_difficulty(checkbox.pressed) * globals.difficulty.DIFFICULTY_MULTIPLIERS.desire_curios_give_perturbation)

func _on_total_difficulty_changed(total_difficulty) -> void:
	_total_difficulty.text = "Difficulty: " + str(total_difficulty) 

func _convert_act_healing_to_pct(value: int) -> float:
	var pct : float
	match value:
		0: pct = 1
		1: pct = 0.75
		2: pct = 0.5
		3: pct = 0.25
		4: pct = 0
	return(pct)

func _convert_act_healing_to_int(value: float) -> int:
	var int_value : int
	match value:
		0.0: int_value = 4
		0.25: int_value = 3
		0.5: int_value = 2
		0.75: int_value = 1
		1.0: int_value = 0
	return(int_value)
