extends Area2D

@onready var player = %Player

func _on_body_entered(body):
	player.collect_battery()
	print('got battery')
	queue_free()
