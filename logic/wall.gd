extends Area2D

signal reset_ball


func _on_wall_area_entered(area):
	if area.name == "Ball":
		#oops, ball went out of game place, reset
		emit_signal("reset_ball")
		area.reset()
