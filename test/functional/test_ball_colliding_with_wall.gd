extends "res://addons/gut/test.gd"

const START_POSITION_LEFT := Vector2(20, 50)
const START_POSITION_RIGHT := Vector2(40, 50)
const MAX_YIELD_WAIT_TIME := 1

var ball_packedscene = load("res://ball.tscn")
var wall_packedscene = load("res://wall.tscn")


func test_ball_resets_on_hitting_wall():
	var wall = autofree(wall_packedscene.instance())
	wall.position = START_POSITION_LEFT
	add_child(wall)
	var ball = autofree(ball_packedscene.instance())
	ball.position = START_POSITION_RIGHT
	add_child(ball)
	assert_true(ball.direction.x < 0, "ball should be moving left")
	watch_signals(wall)
	watch_signals(ball)
	yield(yield_to(wall, "reset_ball", MAX_YIELD_WAIT_TIME), YIELD)
	assert_signal_emitted(wall, "reset_ball")
	assert_signal_emitted(ball, "reset")
