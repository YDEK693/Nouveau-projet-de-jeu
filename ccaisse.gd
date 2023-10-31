extends RigidBody2D

var current_stage = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func go_next_stage():
	current_stage += 1
	get_tree().change_scene("res://Scenes/Levels/Level "+str(current_stage)+".xml")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

