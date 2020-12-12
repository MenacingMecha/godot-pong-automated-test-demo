extends "res://addons/gut/test.gd"

var wall_class = load("res://logic/wall.gd")
var ball_class = load("res://logic/ball.gd")

func test_ball_should_reset_on_hitting_wall():
	var wall = add_child_autofree(wall_class.new())
	watch_signals(wall)
	var mock_area = autofree(Area2D.new())
	wall._on_wall_area_entered(mock_area)
	assert_signal_not_emitted(wall, "reset_ball", "Ball should not be reset on generic area hitting wall")
	# crashes if ball isn't added to scene
	# the ball should always be in the scene, so this is fine
	var mock_ball = add_child_autofree(ball_class.new())
	# balls need to explicitly be named "Ball" to work
	mock_ball.name = "Ball"
	wall._on_wall_area_entered(mock_ball)
	assert_signal_emitted(wall, "reset_ball", "Ball should be reset on hitting wall")

