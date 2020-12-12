extends Area2D

signal ball_bounced

export var _bounce_direction = 1


func _on_area_entered(area):
	if area.name == "Ball":
		emit_signal("ball_bounced")
		area.bounce_wall_ceiling(_bounce_direction)
