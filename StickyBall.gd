extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# This represents the player's inertia.
const push_force = 80.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	pass

func _physics_process(delta):
		velocity.x = 0
		velocity.y = 0
		move_and_collide(- get_real_velocity() * delta)
		
