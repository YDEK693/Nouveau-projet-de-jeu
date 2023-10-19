extends RigidBody2D

@export var jump_impulse = 20
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Gestion de la direction
	if Input.is_action_pressed("ui_right"):
		apply_central_impulse(Vector2(10,0));
	if Input.is_action_pressed("ui_left"):
		apply_central_impulse(Vector2(-10,0));
	if Input.is_action_pressed("ui_select"):
		apply_central_impulse(Vector2(0,-100));
 
