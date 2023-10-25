extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_button_pushed():
	set_collision_layer_value(1,true);
	visible = true

	


func _on_button_button_off_pushed():
	set_collision_layer_value(1,false);
	visible = false
