extends "res://addons/gut/test.gd"

const START_POSITION_LEFT := Vector2(20, 50)
const START_POSITION_RIGHT := Vector2(40, 50)

var ball_packedscene = load("res://ball.tscn")
var paddle_packedscene = load("res://paddle.tscn")

func test_ball_bounces_off_left_paddle():
	var paddle = autofree(paddle_packedscene.instance())
	paddle.name = "Left"
	paddle.position = START_POSITION_LEFT
	add_child(paddle)
	var ball = autofree(ball_packedscene.instance())
	ball.position = START_POSITION_RIGHT
	add_child(ball)
	assert_true(ball.direction.x < 0, "ball should be moving left")
	watch_signals(paddle)
	yield(yield_to(paddle, "bounce", 1), YIELD)
	assert_signal_emitted(paddle, "bounce")
	assert_true(ball.direction.x > 0, "ball should be moving right")

func test_ball_bounces_off_right_paddle():
	var paddle = autofree(paddle_packedscene.instance())
	paddle.name = "Right"
	paddle.position = START_POSITION_RIGHT
	add_child(paddle)
	var ball = autofree(ball_packedscene.instance())
	ball.position = START_POSITION_LEFT
	add_child(ball)
	ball.direction.x = 1
	assert_true(ball.direction.x > 0, "ball should be moving right")
	watch_signals(paddle)
	yield(yield_to(paddle, "bounce", 1), YIELD)
	assert_signal_emitted(paddle, "bounce")
	assert_true(ball.direction.x < 0, "ball should be moving left")
