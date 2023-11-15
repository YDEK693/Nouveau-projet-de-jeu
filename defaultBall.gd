extends CharacterBody2D

# This represents the player's inertia.
const push_force = 80.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Création d'une énumération pour les états
enum State {
	DEFAULT,
	STICKY,
}

var SPEEDDIC =  {State.DEFAULT : 300.0, State.STICKY: 150}
var JUMPDIC = {State.DEFAULT : -400.0, State.STICKY: -200}

var current_state : State = State.DEFAULT
func _ready():
	pass

func _physics_process(delta):
	
	var SPEED = SPEEDDIC[current_state]
	var JUMP_VELOCITY = JUMPDIC[current_state]
	#gauche droite jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	
	if current_state == State.STICKY:
		if(is_on_wall() || is_on_ceiling()):
			velocity.y = 0
			#var velo = -get_real_velocity()
			#velo.y = 0
			#move_and_collide(velo*delta)	
		else:
			velocity.y += gravity * delta
			
	else:	
		velocity.y += gravity * delta	
	if(is_on_floor()):
		print('flor')
		velocity.y = JUMP_VELOCITY*2
	
	move_and_slide()
		
	if Input.is_action_just_pressed("ui_focus_next"):
		if current_state == State.DEFAULT:
			current_state = State.STICKY
		else:
			current_state = State.DEFAULT
	
	#push caisse
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
			


func _on_area_2d_body_entered(body):
	if body.is_in_group("Platform"):
		print("lol")
