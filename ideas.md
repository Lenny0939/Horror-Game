
# Enemy
can teleport when out of site, though not too much, possibly a limit 
cannot go through walls when close, when going through secure doors must wait 10s 
teleports when the player is too noisy, or when behind 
teleportation is more powerful depending on noise level, when behind it is subtle 
quite slow when close, relies on trapping player		
can seal up exits if there are multiple, and it isn't too unfair for the player 

## things to calculate 
### when to teleport 
 - when either far away or player is noisy 
 when to block doorways 
 - have to calculate fairness of this 
 when to wander or pursue 
 - depends on noise and distance, also will increase throughout the night ad week
 when to jumpscare
 - pretty easy, when player discovers it. probably a raycast from the torch. 
### variable about aggression
 - things it affects 
 	movement speed
 	wander or pursue 
 	teleportation 
 - things that affect it 
 	what day you're on 
 	time of the night 
 	how noisy the player is and has been 
 	player distance 
 	whether the player can see it 

 separate multipliers for day and time of night 
 multiplier for player noise 
 divide by player distance * something 
 if player can see it aggression automatically goes to max

# Terrain Generation

Each night the mansion shifts
You start in one room in the middle with a sunroof, monster can't come here during the night 
Each room fits in a grid
Corridors
Various combinations of doors 
For every open door random number, if it is a certain one then a dead end is created 
gets more and more likely as the distance gets higher
if not, a random room is created that fits with what is already generated

When creating a room in a position checks all four sides
If there is a door there, a door must be created 
If not, a random number based on the number of rooms already existed is rolled
Dead ends become more likely if there are more existing rooms 
Maximum chance of a door is 75%
Different room sprites, apart from corridors and other special rooms they can all accomodate doors 
stored in 9x9 array, each element of that array is another array with either true or false for first whether the room is there, and then if each door is there 
when creating a room 
```gdscript
if(rooms[x - 1][y][east]):
	rooms[x][y][west] = true
elif(random(0, 3) != 0):
	rooms[x][y][west] = true
```
and so on for each cardinal direction
i think ill have to do a lot of nested for loops

until there are no open doors left, the above code is executed for every open door multiple times until there are no open doors
