extends Button

func _ready() -> void:

	pass 

func _process(delta: float) -> void:

	pass

func _pressed() -> void:
	Global.gameMode = Global.gameModes.Measurements
	Global.gameMaster.changeGameState(Global.gameStates.Playing)
