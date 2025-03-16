extends Control



func _ready() -> void:
	%NextLevelButton.pressed.connect(func():Globals.s_nextLevel.emit())
