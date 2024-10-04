extends Control
var x = 0
var labelPos = load("res://label_pos.tscn")
var loadedLabel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	while(x <= 300):
		loadedLabel = labelPos.instantiate()
		loadedLabel.x = x
		print(x * Global.meter)
		loadedLabel.set_position(Vector2(x * Global.meter, 1000))
		add_child(loadedLabel)
		x += 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
