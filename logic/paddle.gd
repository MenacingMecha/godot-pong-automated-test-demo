extends Area2D

signal paddle_hit
const MOVE_SPEED = 100

var _ball_dir
var _up
var _down

onready var _screen_size_y = get_viewport_rect().size.y


func _ready():
	var n = name.to_lower()
	_up = n + "_move_up"
	_down = n + "_move_down"
	_ball_dir = 1 if n == "left" else -1


func _process(delta):
	# Move up and down based on input.
	var input = Input.get_action_strength(_down) - Input.get_action_strength(_up)
	move(input, delta)


func move(vertical_direction: float, delta: float):
	# TODO: magic number >:(
	position.y = clamp(
		position.y + vertical_direction * MOVE_SPEED * delta, 16, _screen_size_y - 16
	)


func _on_area_entered(area):
	if area.name == "Ball":
		emit_signal("paddle_hit")
		area.on_paddle_hit(_ball_dir)
