extends Node2D
var distance:float
var artiAngle:float
var gravity:float = 9.8
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gravity = 9.8
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func camState(state:bool):
	$levelCamera.set_enabled(state)

func addEnemy(pos:Vector2) -> void:
	$CanvasLayer/EnemyList.addNewEnemy(pos)

func killEnemy(pos:Vector2) -> void:
	var numEnem = 0
	for i in $CanvasLayer/EnemyList.get_child(0).get_children():
		numEnem += 1
		if (i.text == str("Enemy located at ", int(pos.x / 75) , "m" ,", ", int(pos.y / 75),"m")):
			i.queue_free()
			numEnem -= 1
	if numEnem <= 0:
		print("a")
		Global.gameMaster.changeGameState(Global.gameStates.Start)
	print($CanvasLayer/EnemyList.get_child(0).get_children())
	
	
func updateAngle(angle:float) -> void:
	artiAngle = angle
	if (distance != null):
		var Vi = str(sqrt((gravity * distance) / sin(deg_to_rad(artiAngle * 2))))
		$CanvasLayer/Label2.text = "Initial Velocity required: " + Vi


func _on_line_edit_text_changed(new_text: String) -> void:
	artiAngle = $Artillery.angle
	distance = snapped(float(new_text), 0.1)
	gravity = 9.8
	print(artiAngle)
	var Vi = str(sqrt((gravity * distance) / sin(deg_to_rad(artiAngle * 2))))
	$CanvasLayer/Label2.text = "Initial Velocity required: " + Vi
