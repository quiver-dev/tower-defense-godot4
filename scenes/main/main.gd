extends Node2D


@onready var objective := $Objective as Area2D
@onready var spawner := $Spawner as Spawner


func _ready() -> void:
	spawner.start(objective.global_position)
