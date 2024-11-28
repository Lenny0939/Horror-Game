extends StaticBody2D

@onready var area = $Area2D
@onready var player = $"../Player"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if($Area2D.overlaps_body($"../Player") && Input.is_action_pressed("door")):
		#TODO change animation
		$CollisionShape2D.disabled = not $CollisionShape2D.disabled