extends Node2D
var distance # null value at start
var artiAngle:float
var gravity:float = 9.8
var dictOfEnemy:Array[Dictionary] = []

var base1Scene = load("res://Enemy/base_1.tscn")
var base2Scene = load("res://Enemy/base_2.tscn")
var base3Scene = load("res://Enemy/base_3.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var base1 = base1Scene.instantiate()
	var base2 = base2Scene.instantiate()
	var base3 = base3Scene.instantiate()
	
	base1.set_global_position(Vector2(Global.rngMaster.randi_range(16000, 20000), 820))
	base2.set_global_position(Vector2(Global.rngMaster.randi_range(11000, 15000), 800))
	base3.set_global_position(Vector2(Global.rngMaster.randi_range(4500, 10000), 820))
	
	add_child(base1)
	add_child(base2)
	add_child(base3)
	
	if Global.gameMode == Global.gameModes.ProjectileMotion:
		$UI/LineEdit.visible = false
	elif Global.gameMode == Global.gameModes.Measurements:
		$Ruler.visible = false
	gravity = 9.8
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func camState(state:bool):
	$levelCamera.set_enabled(state)
	
	if (state == true):
		$UI/Angle.set_visible(true)
		$UI/Force.set_visible(true)
		$UI/fireButton.set_visible(true)
		$UI/AngleText.set_visible(true)
		$UI/InitVText.set_visible(true)
	if (state == false):
		$UI/Angle.set_visible(false)
		$UI/Force.set_visible(false)
		$UI/fireButton.set_visible(false)
		$UI/AngleText.set_visible(false)
		$UI/InitVText.set_visible(false)

func addEnemy(enemyInstanceId:int, pos:Vector2, maxHp) -> void:
	var EnemyNode = instance_from_id(enemyInstanceId)
	var enemyListingNode = $UI/EnemyList.addNewEnemyToList(pos, maxHp)
	var EnemyDict = {"EnemyId": enemyInstanceId, "EnemyListingId": enemyListingNode.get_instance_id()}
	dictOfEnemy.append(EnemyDict)

func updateHp(EnemyInstanceId:int, hp:int):
	var index:int = 0
	var EnemyListingInstanceId:int
	var Enemy = instance_from_id(EnemyInstanceId)
	var EnemyListing:Object
	for i in dictOfEnemy:
		
		if i.get("EnemyId") == EnemyInstanceId:
			EnemyListingInstanceId = i.get("EnemyListingId")
			EnemyListing = instance_from_id(EnemyListingInstanceId)
			EnemyListing.updateHp(hp)
			
			break
		index += 1
			
	if Enemy.hp <= 0:
		Enemy.queue_free()
		EnemyListing.queue_free()
		dictOfEnemy.pop_at(index)
		
		
		
	if dictOfEnemy.is_empty():
		Global.gameMaster.changeGameState(Global.gameStates.Start)
	
func updateAngle(angle:float) -> void:
	artiAngle = angle
	if (distance != null):
		var Vi = str(sqrt((gravity * distance) / sin(deg_to_rad(artiAngle * 2))))
		$UI/Label2.text = "Initial Velocity required: " + Vi


func _on_line_edit_text_changed(new_text: String) -> void:
	artiAngle = $Artillery.angle
	distance = snapped(float(new_text), 0.1)
	gravity = 9.8
	print(artiAngle)
	var Vi = str(sqrt((gravity * distance) / sin(deg_to_rad(artiAngle * 2))))
	$UI/Label2.text = "Initial Velocity required: " + Vi
