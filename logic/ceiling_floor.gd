extends Area2D

export var _bounce_direction = 1


func _on_area_entered(area):
	if area.name == "Ball":
		area.bounce_wall_ceiling(_bounce_direction)
