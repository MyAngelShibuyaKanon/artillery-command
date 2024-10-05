extends Node2D
var meter = 75; #one meter is 75 pixels
enum gameStates{
	Start,
	Playing,
	End
}

@onready var gameMaster:Node = get_node("/root/gameMaster")

var Enemies = []
