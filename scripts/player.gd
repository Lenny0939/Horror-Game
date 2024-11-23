extends CharacterBody2D

var speed = 200  # speed in pixels/sec
var direction_facing: Vector2

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed * delta * 60
	if not direction.is_zero_approx():
		direction_facing = direction
	print(direction_facing)
	if(Input.is_action_just_pressed("light")):
		get_node("torch").enabled = true
		
	if(Input.is_action_just_released("light")):
		get_node("torch").enabled = false
	
	get_node("torch").rotation_degrees = rad_to_deg(direction_facing.angle())
	move_and_slide()
