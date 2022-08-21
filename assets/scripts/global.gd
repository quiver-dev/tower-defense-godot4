extends Node


var is_gameover := false
var turret_actions: Control = null  # used to ensure only one is visible in the map
var money: int
var turret_prices := {
	"gatling": 250,
	"single": 400,
	"missile": 800,
}


# Function to wrap an index around an array (circular array)
static func wrap_index(index: int, size: int) -> int:
	return ((index % size) + size) % size
