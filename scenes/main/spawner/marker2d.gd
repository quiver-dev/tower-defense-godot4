class_name SpawnLocation
extends Marker2D
# Simple script to specify if the current marker will be used to spawn
# air or ground entities


@export_enum("Ground", "Air") var spawn_type: int
