class_name Turn
extends Node

const PLAYER_SIGNALS := [
	"player_turn_started",
	"player_turn_ended",
]
const ENEMY_SIGNALS := [
	"enemy_turn_started",
	"enemy_turn_ended",
]

const ALL_SIGNALS := PLAYER_SIGNALS + ENEMY_SIGNALS

signal player_turn_started(turn)
signal player_turn_ended(turn)
signal enemy_turn_started(turn)
signal enemy_turn_ended(turn)
# Tracks the first of each card to have been played each turn
var firsts := {}


func _init() -> void:
	pass

func setup() -> void:
	cfc.NMAP.board.end_turn.connect("pressed", self, "end_player_turn")
	for obj in [cfc.NMAP.board]:
		for turn_signal in ALL_SIGNALS:
			# warning-ignore:return_value_discarded
			connect(turn_signal, obj, "_on_" + turn_signal)
	for obj in [cfc.NMAP.board.counters, cfc.NMAP.hand]:
		for turn_signal in PLAYER_SIGNALS:
			# warning-ignore:return_value_discarded
			connect(turn_signal, obj, "_on_" + turn_signal)
		
func start_player_turn() -> void:
	emit_signal("player_turn_started", self)
	
func end_player_turn() -> void:
	emit_signal("player_turn_ended", self)
		
func start_enemy_turn() -> void:
	emit_signal("enemy_turn_started", self)
	
func end_enemy_turn() -> void:
	emit_signal("enemy_turn_ended", self)
