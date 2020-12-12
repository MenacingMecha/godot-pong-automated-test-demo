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


func on_paddle_hit(base_h_direction: float):
	direction = Vector2(base_h_direction, randf() * 2 - 1).normalized()


func on_side_hit(bounce_direction: int):
	# hard to test exact value as it adds the direction to itself rather than setting directly
	direction = (direction + Vector2(0, bounce_direction)).normalized()
