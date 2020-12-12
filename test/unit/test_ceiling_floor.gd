extends "res://addons/gut/test.gd"

var ceiling_floor_class = load("res://logic/ceiling_floor.gd")
var ball_class = load("res://logic/ball.gd")


func test_ball_bounces_off_floor_ceiling():
	var ceiling = add_child_autofree(ceiling_floor_class.new())
	watch_signals(ceiling)
	var mock_area = autofree(Area2D.new())
	ceiling._on_area_entered(mock_area)
	assert_signal_not_emitted(
		ceiling, "ball_bounced", "shouldn't bounce ball on generic area entered"
	)
	var ball = autofree(ball_class.new())
	# balls need to explicitly be named "Ball" to work
	ball.name = "Ball"
	ceiling._on_area_entered(ball)
	assert_signal_emitted(ceiling, "ball_bounced", "ball should bounce on area entered")
