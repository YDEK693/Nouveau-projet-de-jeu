extends CharacterBody2D

# This represents the player's inertia.
const push_force = 80.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var sens = 1 
# Création d'une énumération pour les états
enum State {
	DEFAULT = 0,
	STICKY = 1,
}
var DEPLOQUER = [State.DEFAULT, State.STICKY]
var SPEEDDIC =  {State.DEFAULT : 300.0, State.STICKY: 150}
var JUMPDIC = {State.DEFAULT : -400.0, State.STICKY: -200}

var current_state : State = State.DEFAULT
func _ready():
	pass

func _physics_process(delta):
	var SPEED = SPEEDDIC[current_state]
	var JUMP_VELOCITY = JUMPDIC[current_state]
	#gauche droite jump
	
	#balle de tennis
#	if(velocity.y>0 && is_on_floor()):
#		velocity.y += JUMP_VELOCITY*2

	
	#restart level à definir la touche
	
	#changer de transformation
	if Input.is_action_just_pressed("ui_focus_next"):
		current_state = DEPLOQUER[(current_state + 1) % len(DEPLOQUER)]
		if current_state == State.STICKY:
			pass
		#	$CollisionBoule.shape.radius = 10
			#$AnimatedSpriteBoule.play("sticky")
		elif current_state == State.DEFAULT:
			$CollisionBoule.shape.radius = 42.11
			#$AnimatedSpriteBoule.play("default")
		
	#push caisse
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is AnimatableBody2D:
			if c.get_collider().position.x > 490:
				sens = -1 
			if c.get_collider().position.x < 10:
				sens = 1
	
	#deplacement
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	#moving plateforme
	if current_state == State.STICKY:
#		if(is_on_ceiling()):
#			velocity.y = 0
#			velocity.x = 400*sens;
#		if(is_on_wall()):
#			velocity.y = 0
#			velocity.x = 500*sens;
		if(is_on_ceiling()||is_on_wall()):
			velocity.x = 200*sens;
		else:
			velocity.y += gravity * delta

	else:	
		velocity.y += gravity * delta	
	move_and_slide()
	
# if needed for bouncing of walls or ceilings
#var was_on_wall := false
#var was_on_ceiling
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("Platform"):
		print("lol")
