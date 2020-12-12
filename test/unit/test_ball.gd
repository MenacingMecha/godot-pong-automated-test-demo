extends "res://addons/gut/test.gd"

const SIMULATE_TIME := 3
const SIMULATE_DELTA := 10

var ball_class = load("res://logic/ball.gd")


func test_ball_should_move_on_process():
	var ball = ball_class.new()
	add_child_autofree(ball)
	gut.simulate(ball, SIMULATE_TIME, SIMULATE_DELTA)
	assert_false(ball.position == ball._initial_pos, "ball isn't equal to default position")

	# this is hard to calculate as ball._speed changes dynamically
	# var expected_position : Vector2 = (ball.direction * ball.DEFAULT_SPEED * SIMULATE_DELTA) * SIMULATE_TIME
	# assert_eq(ball.position, expected_position, "ball position should equal expected position")


func test_members_are_reset_on_reset():
	var ball = ball_class.new()
	add_child_autofree(ball)
	var default_direction = ball.direction
	var non_default_direction = Vector2.RIGHT
	ball.direction = non_default_direction
	var default_position = ball._initial_pos
	var non_default_position = Vector2(20, 40)
	ball.position = non_default_position
	var non_default_speed = 20
	ball._speed = non_default_speed
	ball.reset()
	assert_eq(ball.direction, default_direction, "ball direction should be default after reset")
	assert_eq(ball.position, default_position, "ball position should be default after reset")
	assert_eq(ball._speed, ball.DEFAULT_SPEED, "ball position should be default after reset")


func test_ball_direction_changes_on_hitting_paddle():
	var ball = add_child_autofree(ball_class.new())
	var bounce_direction_x_right := 1
	ball.bounce(bounce_direction_x_right)
	assert_true(ball.direction.x > 0, "ball should move right after hitting left paddle")
	var bounce_direction_x_left := -1
	ball.bounce(bounce_direction_x_left)
	assert_true(ball.direction.x < 0, "ball should move left after hitting right paddle")
	# y direction is random so not suited for testing here
	# could test the y direction seperately for valid input but not worth the effort


func test_ball_direction_changes_on_hitting_ceiling_floor():
	var ball = add_child_autofree(ball_class.new())
	var ceiling_bounce_direction := 1
	ball.bounce_wall_ceiling(ceiling_bounce_direction)
	assert_true(
		ball.direction.y > 0, "after bouncing off the ceiling, the ball should be moving down"
	)
	var floor_bounce_direction := -1
	ball.bounce_wall_ceiling(floor_bounce_direction)
	assert_true(ball.direction.y < 0, "after bouncing off the floor, the ball should be moving up")
