extends Label
var maxHp

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ProgressBar.set_min(0)
	$ProgressBar.set_max(maxHp)
	$ProgressBar.set_value(maxHp)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func updateHp(hp:int) -> void:
	$ProgressBar.set_value(hp)
	print("a")
