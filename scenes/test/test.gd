extends Node2D


func _ready() -> void:
	for enemy in $Enemies.get_children():
		(enemy as Enemy).move_to($Objective.global_position)
