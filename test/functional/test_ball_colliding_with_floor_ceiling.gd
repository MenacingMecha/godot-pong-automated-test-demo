extends "res://addons/gut/test.gd"

const START_POSITION_TOP := Vector2(20, 80)
const START_POSITION_BOT := Vector2(20, 110)
const BALL_DIRECTION_X := 0.8
const MAX_YIELD_WAIT_TIME := 1

var ball_packedscene = load("res://ball.tscn")
var floor_ceiling_packedscene = load("res://floor_ceiling.tscn")


func test_ball_bounces_off_ceiling():
	var ceiling = autofree(floor_ceiling_packedscene.instance())
	ceiling.position = START_POSITION_TOP
	add_child(ceiling)
	ceiling._bounce_direction = 1
	var ball = autofree(ball_packedscene.instance())
	ball.position = START_POSITION_BOT
	add_child(ball)
	ball.direction = Vector2(BALL_DIRECTION_X, -1).normalized()
	assert_true(ball.direction.y < 0, "ball should be moving up")
	watch_signals(ceiling)
	yield(yield_to(ceiling, "ball_bounced", MAX_YIELD_WAIT_TIME), YIELD)
	assert_signal_emitted(ceiling, "ball_bounced")
	assert_true(ball.direction.y > 0, "ball should be moving down")


func test_ball_bounces_off_floor():
	var test_floor = autofree(floor_ceiling_packedscene.instance())
	test_floor.position = START_POSITION_BOT
	add_child(test_floor)
	test_floor._bounce_direction = -1
	var ball = autofree(ball_packedscene.instance())
	ball.position = START_POSITION_TOP
	add_child(ball)
	ball.direction = Vector2(BALL_DIRECTION_X, 1).normalized()
	assert_true(ball.direction.y > 0, "ball should be moving down")
	watch_signals(test_floor)
	yield(yield_to(test_floor, "ball_bounced", MAX_YIELD_WAIT_TIME), YIELD)
	assert_signal_emitted(test_floor, "ball_bounced")
	assert_true(ball.direction.y < 0, "ball should be moving up")
