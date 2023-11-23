extends CharacterBody2D

# This represents the player's inertia.
const push_force = 30.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var sens = 1 
# Création d'une énumération pour les états
enum State {
	DEFAULT = 0,
	TENNIS = 1,
	STICKY = 2,
	
}

signal tennis
signal default
signal sticky 

var DEPLOQUER = [State.DEFAULT]
var SPEEDDIC =  {State.DEFAULT : 300.0, State.STICKY: 150, State.TENNIS: 300.0}
var JUMPDIC = {State.DEFAULT : -400.0, State.STICKY: -200, State.TENNIS: -600.0}

var current_state : State = State.DEFAULT
func _ready():
	print($CollisionBoule.shape.radius)
	$AnimatedSpriteBoule.play("default")
	var current_scene_file = get_tree().current_scene.scene_file_path
	var lvl3 = "res://Niveaux/3.tscn"
	if(current_scene_file == lvl3):
		var new_script = preload("res://Personnage/CharaterBody2dlvl3.gd")
		self.set_script(new_script)

func addTennisTransformation() : 
	if State.TENNIS not in DEPLOQUER:
		DEPLOQUER.append(State.TENNIS)
	$AnimatedSpriteBoule.play("tennis")
	current_state = State.TENNIS
func _physics_process(delta):
	var SPEED = SPEEDDIC[current_state]
	var JUMP_VELOCITY = JUMPDIC[current_state]


	#restart level
	if Input.is_action_just_pressed("Reset"):
		var current_scene_file = get_tree().current_scene.scene_file_path
		get_tree().change_scene_to_file(current_scene_file)
	#changer de transformation
	if Input.is_action_just_pressed("Transformation"):
		current_state = DEPLOQUER[(current_state + 1) % len(DEPLOQUER)]
		if current_state == State.STICKY:
			$CollisionBoule.shape.radius = 42.11
			$AnimatedSpriteBoule.scale.x = 0.279
			$AnimatedSpriteBoule.scale.y = 0.27
			$AnimatedSpriteBoule.play("sticky")
			emit_signal("sticky")
		elif current_state == State.DEFAULT:
			$CollisionBoule.shape.radius = 42.11
			$AnimatedSpriteBoule.scale.x = 0.279
			$AnimatedSpriteBoule.scale.y = 0.27
			$AnimatedSpriteBoule.play("default")
			emit_signal("default")
		elif current_state == State.TENNIS:
			$CollisionBoule.shape.radius = 21.05
			$AnimatedSpriteBoule.scale.x = 0.150
			$AnimatedSpriteBoule.scale.y = 0.15
			$AnimatedSpriteBoule.play("tennis")
			emit_signal("tennis")
	#push caisse
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
	#deplacement
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED
	
	velocity.y += gravity * delta	
	move_and_slide()

	#moving plateforme

	
	
# if needed for bouncing of walls or ceilings
#var was_on_wall := false
#var was_on_ceiling

