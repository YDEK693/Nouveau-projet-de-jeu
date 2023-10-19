extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Droite"):
		apply_central_impulse(Vector2(2,0))
	if Input.is_action_pressed("Gauche"):
		apply_central_impulse(Vector2(-2,0))
	if Input.is_action_pressed("Saut") and :
		apply_central_impulse(Vector2(0,-50))


func _on_body_entered(body):
	pass # Replace with function body.
