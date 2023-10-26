extends StaticBody2D

var onButton := false
signal buttonPushed
signal buttonOffPushed
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if onButton :
		$AnimatedSprite2D.play("down")
		emit_signal("buttonPushed")
	else:
		$AnimatedSprite2D.play("up")
		emit_signal("buttonOffPushed")

func _on_top_checker_body_entered(body):
	if body.is_in_group("Object"):
		onButton = true


func _on_top_checker_body_exited(body):
	if body.is_in_group("Object"):
		onButton = false

