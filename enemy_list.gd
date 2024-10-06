extends Control
var enemyLabel = load("res://Ui/EnemyInf.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func addNewEnemyToList(pos:Vector2, maxHp) -> Node:
	var label = enemyLabel.instantiate()
	label.maxHp = maxHp
	if Global.gameMode == Global.gameModes.ProjectileMotion:
		label.text = str("Enemy located at ", int(pos.x / 75) , "m" ,", ", int(pos.y / 75),"m")
	else:
		label.text = str("Enemy located at ", Global.convertUnitToRandom(int(pos.x / 75)) ,", ", Global.convertUnitToRandom(int(pos.y / 75)))
	$VBoxContainer.add_child(label)
	return(label)
