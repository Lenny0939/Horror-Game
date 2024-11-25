extends CharacterBody2D

const max_battery = 600
var speed = 200  # speed in pixels/sec
var batteries = 5
var battery = 600
var direction_facing: Vector2
@onready var torch = get_node("torch")
enum battery_users {
	door,
	mega_flashlight,
}

func _physics_process(delta):
	$"../CanvasLayer/Battery Label".text = str(battery)
	$"../CanvasLayer/Batteries Label".text = str(batteries)
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed * delta * 60
	if not direction.is_zero_approx():
		direction_facing = direction
	print(direction_facing)
	
	if(Input.is_action_just_pressed("use_battery") && batteries > 0):
		if ($Area2D.overlaps_area($"door")):
			print("door")
		elif ($Area2D.overlaps_area($"mega_flashlight")):
			print("megaflashlight")
		else:
			batteries -= 1
			battery = max_battery
	
	if(Input.is_action_pressed("light") && battery > 0):
		$torch.enabled = true
		battery -=1
	else:
		$torch.enabled = false
	
	get_node("torch").rotation_degrees = rad_to_deg(direction_facing.angle())
	move_and_slide()
