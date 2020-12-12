extends Area2D

const DEFAULT_SPEED = 100

var direction = Vector2.LEFT

onready var _initial_pos = position
onready var _speed = DEFAULT_SPEED


func _process(delta):
	_speed += delta * 2
	position += _speed * delta * direction


func reset():
	direction = Vector2.LEFT
	position = _initial_pos
	_speed = DEFAULT_SPEED


func bounce(base_h_direction: float):
	direction = Vector2(base_h_direction, randf() * 2 - 1).normalized()


func bounce_wall_ceiling(bounce_direction: int):
	direction = (direction + Vector2(0, bounce_direction)).normalized()
