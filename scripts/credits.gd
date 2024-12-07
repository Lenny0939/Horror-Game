extends Control

@onready var timer := Timer.new()
var scroll = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.autostart = true
	timer.wait_time = 3.0
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
func _on_timer_timeout():
	$Credits.visible = true
	scroll = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if scroll: position.y -= 0.2
