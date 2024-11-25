extends Area2D

# Enemy pseudo code
#can teleport when out of site, though not too much, possibly a limit 
#cannot go through walls when close, when going through secure doors must wait 10s 
#teleports when the player is too noisy, or when behind 
#teleportation is more powerful depending on noise level, when behind it is subtle 
#quite slow when close, relies on trapping player		
#can seal up exits if there are multiple, and it isn't too unfair for the player 

#things to calculate 
# when to teleport 
# - when either far away or player is noisy 
# when to block doorways 
# - have to calculate fairness of this 
# when to wander or pursue 
# - depends on noise and distance, also will increase throughout the night ad week
# when to jumpscare
# - pretty easy, when player discovers it. probably a raycast from the torch. 
# variable about aggression
# - things it affects 
# 	movement speed
# 	wander or pursue 
# 	teleportation 
# - things that affect it 
# 	what day you're on 
# 	time of the night 
# 	how noisy the player is and has been 
# 	player distance 
# 	whether the player can see it 
#
# separate multipliers for day and time of night 
# multiplier for player noise 
# divide by player distance * something 
# if player can see it aggression automatically goes to max

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
