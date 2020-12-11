extends "res://addons/gut/test.gd"

var paddle_class = load("res://logic/paddle.gd")

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
