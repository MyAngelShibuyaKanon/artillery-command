extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func addNewEnemy(pos:Vector2) -> void:
	var label = Label.new()
	label.text = str("Enemy located at ", int(pos.x / 75) , "m" ,", ", int(pos.y / 75),"m")
	$VBoxContainer.add_child(label)
	pass
