extends Button

func _ready() -> void:

	pass 

func _process(delta: float) -> void:

	pass

func _pressed() -> void:
	Global.gameMaster.changeGameState(Global.gameStates.Playing)
