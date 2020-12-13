extends Node

var pong_scene_path = "res://pong.tscn"
var test_runner_scene_path = "res://test/gut.tscn"


func _input(_event):
	# I don't think it's possible to test these
	if Input.is_action_just_pressed("kb_1"):
		get_tree().change_scene(pong_scene_path)
	if Input.is_action_just_pressed("kb_2"):
		get_tree().change_scene(test_runner_scene_path)
