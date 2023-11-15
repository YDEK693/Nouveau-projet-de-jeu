extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Object"):
		var current_scene_file = get_tree().current_scene.scene_file_path
		print(current_scene_file)
		get_tree().change_scene_to_file(current_scene_file)
