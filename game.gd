extends Node2D

var level1 = preload("res://levels/level_1.tscn")

var currentLevel = 1
var loadedLevelScene

func _ready() -> void:
	Globals.s_levelComplete.connect(loadNextLevel)
	return

func loadNextLevel():
	showNextLevelMenu()
	return
	currentLevel += 1
	loadLevel(currentLevel)

func showNextLevelMenu():
	%CongratsMenu.visible = true

func loadLevel(lvl=1):
	var levelPath = "res://levels/level_" + str(lvl) +  ".tscn"
	var levelScene = load(levelPath)
	if not levelScene:
		return
	loadedLevelScene = levelScene.new()
	$'.'.add_child(loadedLevelScene)
