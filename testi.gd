extends RigidBody2D
var jump = true
var bord = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Droite") and !bord:
		apply_central_impulse(Vector2(2,0))
	if Input.is_action_pressed("Gauche") and !bord:
		apply_central_impulse(Vector2(-2,0))
	if Input.is_action_pressed("Saut") and jump:
		jump = false
		apply_central_impulse(Vector2(0,-100))


func _on_body_entered(body):
	if body.is_in_group("Sol"):
		print("Contacte ")
		jump = true
		
	if body.is_in_group("BordMap"):
		bord = true
		print("Entrer ", bord)



func _on_body_exited(body):
	if body.is_in_group("BordMap"):
		bord = false
		print("Sortie ", bord)
