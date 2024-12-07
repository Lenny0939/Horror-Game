extends StaticBody2D

@onready var player = $"../Player"
@onready var area = $Area2D

func _ready() -> void:
	if(area.overlaps_body(player)): visible = true 
	else: visible = false

func _on_area_2d_body_entered(_player) -> void:
	if(area.overlaps_body(player)): visible = true 
	else: visible = false

func _on_area_2d_body_exited(_body: Node2D) -> void:
	if area.overlaps_body(player): visible = true 
	else: visible = false
