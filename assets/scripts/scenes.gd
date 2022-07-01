extends Node
# Helper global class used to get information about game scenes.


# Enemies
const INFANTRY_T1 := "res://entities/enemies/infantry/infantry_t1.tscn"
const INFANTRY_T2 := "res://entities/enemies/infantry/infantry_t2.tscn"
const TANK := "res://entities/enemies/tanks/tank.tscn"


static func get_enemy_path(enemy_name: String) -> String:
	var enemy_path: String
	match enemy_name:
		"infantry_t1":
			enemy_path = INFANTRY_T1
		"infantry_t2":
			enemy_path = INFANTRY_T2
		"tank":
			enemy_path = TANK
		_:
			push_error("Cannot get enemy scene from name %s" % enemy_name)
	return enemy_path
