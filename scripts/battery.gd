extends Area2D

func _on_body_entered(body):
	$"../Player".collect_battery()
	print('got battery')
	queue_free()
