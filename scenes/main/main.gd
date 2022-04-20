extends Node2D


@onready var target: Position2D = $Target
@onready var enemy: CharacterBody2D = $Enemy


func _ready() -> void:
	enemy.nav_agent.set_target_location(target.position)
