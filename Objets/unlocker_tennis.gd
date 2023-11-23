extends RigidBody2D


func _ready():
	set_collision_layer_value(1,false);
	visible = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Object"):
		visible = false
		queue_free()



func _on_button_button_pushed():
	set_collision_layer_value(1,true);
	visible = true
