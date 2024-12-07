extends Control

@onready var timer := Timer.new()

func _ready() -> void:
	timer.autostart = true
	timer.wait_time = 30.0
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _input(event):
	if Input.is_action_just_pressed("ui_accept"): get_tree().change_scene_to_file("res://scenes/main.tscn")
