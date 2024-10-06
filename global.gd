extends Node2D
var meter:int = 75; #one meter is 75 pixels
var gameMode:gameModes
@onready var rngMaster = RandomNumberGenerator.new()
enum gameStates{
	Start,
	Playing,
	End
}


enum gameModes{
	ProjectileMotion,
	Measurements
}

@onready var gameMaster:Node = get_node("/root/gameMaster")

func convertUnitToRandom(unit:float) -> String: #expects meter
	var converted:String
	var randomUnit = rngMaster.randi_range(1, 5)
	
	match randomUnit:
		1: #inches
			converted = str(unit * 39.37) + "in"
		2: #yards
			converted = str(unit * 1.09) + "yd"
		3: #ft
			converted = str(unit * 3.28) + "ft"
		4: #km
			converted = str(unit / 1000) + "km"
		5: #cm
			converted = str(unit * 100) + "cm"
			
		
	return converted
