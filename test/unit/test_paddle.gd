extends "res://addons/gut/test.gd"

const DELTA := 2
const DEFAULT_PADDLE_POSITION := Vector2(50, 50)

var paddle_class = load("res://logic/paddle.gd")
var ball_class = load("res://logic/ball.gd")


func test_p1_paddle_inputactions_are_correctly_assigned_on_ready():
	var paddle = paddle_class.new()
	var expected_up := "left_move_up"
	var expected_down := "left_move_down"
	var expected_ball_dir := 1
	paddle.name = "Left"
	add_child_autofree(paddle)
	assert_eq(paddle._up, expected_up)
	assert_eq(paddle._down, expected_down)
	assert_eq(paddle._ball_dir, expected_ball_dir)


func test_p2_paddle_inputactions_are_correctly_assigned_on_ready():
	var paddle = paddle_class.new()
	var expected_up := "right_move_up"
	var expected_down := "right_move_down"
	var expected_ball_dir := -1
	paddle.name = "Right"
	add_child_autofree(paddle)
	assert_eq(paddle._up, expected_up)
	assert_eq(paddle._down, expected_down)
	assert_eq(paddle._ball_dir, expected_ball_dir)


func test_paddle_move_down():
	var paddle = paddle_class.new()
	add_child_autoqfree(paddle)
	paddle.position.y = 50
	paddle.position = DEFAULT_PADDLE_POSITION
	paddle.move(1, DELTA)
	assert_true(
		paddle.position.y > DEFAULT_PADDLE_POSITION.y,
		"paddles position should be higher after moving up"
	)


func test_paddle_move_up():
	var paddle = paddle_class.new()
	add_child_autoqfree(paddle)
	paddle.position = DEFAULT_PADDLE_POSITION
	paddle.move(-1, DELTA)
	assert_true(
		paddle.position.y < DEFAULT_PADDLE_POSITION.y,
		"paddles position should be higher after moving up"
	)


func test_paddle_bounces_ball():
	var paddle = paddle_class.new()
	watch_signals(paddle)
	add_child_autofree(paddle)
	var mock_area = autofree(Area2D.new())
	mock_area.name = "not ball"
	paddle._on_area_entered(mock_area)
	assert_signal_not_emitted(paddle, "paddle_hit", "areas that aren't balls shouldn't bounce")
	var mock_ball = autofree(ball_class.new())
	# balls need to explicitly be named "Ball" to work
	mock_ball.name = "Ball"
	paddle._on_area_entered(mock_ball)
	assert_signal_emitted(paddle, "paddle_hit", "balls should bounce when overlapping paddle")
