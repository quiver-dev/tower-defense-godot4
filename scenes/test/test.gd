extends Node2D


func _ready() -> void:
	Global.money = 1000
	for enemy in $Enemies.get_children():
		(enemy as Enemy).move_to($Objective.global_position)
