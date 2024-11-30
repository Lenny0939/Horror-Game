extends StaticBody2D

@onready var area = $Area2D
@onready var player = $"../Player"
@onready var sprite = $Sprite2D
var open = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if($Area2D.overlaps_body($"../Player") && Input.is_action_just_pressed("door")):
		if open:
			sprite.play("close")
			open = false
			$CollisionShape2D.disabled = false
		else:
			$CollisionShape2D.disabled = not $CollisionShape2D.disabled
			open = true
			sprite.play("open")
