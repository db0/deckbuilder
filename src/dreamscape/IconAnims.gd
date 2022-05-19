# This timer constantly runs and checks if there's animations to play
# If there are, they are fired every 0.1 seconds in FIFO order.
extends Timer

var effects_queue: Array

func _ready():
	connect("timeout",self,"_next_icon_animation")


# Creates an animation based on the provided ImageTexture and animates it between start and end global positions
func send_icon_to_texturerect(icon: ImageTexture, start_pos: Vector2, end_pos: Vector2) -> void:
	var tween := Tween.new()
	# I use TextureRect, as it will resize the icon to the size I need.
	var sprite := TextureRect.new()
	sprite.texture = icon
	sprite.rect_min_size = Vector2(32,32)
	sprite.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	sprite.expand = true
	add_child(tween)
	add_child(sprite)
	# warning-ignore:return_value_discarded
	tween.connect("tween_all_completed",self,"_anim_completed", [tween, sprite])
	# warning-ignore:return_value_discarded
	tween.interpolate_property(sprite,"rect_global_position", start_pos, end_pos, 0.5,Tween.TRANS_SINE, Tween.EASE_IN)
	# warning-ignore:return_value_discarded
	tween.start()


# Cleans up tween and icon
func _anim_completed(tween: Tween, sprite) -> void:
	tween.call_deferred("queue_free")
	sprite.call_deferred("queue_free")


# Triggers every timer timeout. Extracts the next icon from the message and initiates animation
func _next_icon_animation() -> void:
	if effects_queue.size():
		var next_anim_msg: IconAnimMessage = effects_queue.pop_front()
		send_icon_to_texturerect(next_anim_msg.icon, next_anim_msg.start_pos, next_anim_msg.end_pos)
