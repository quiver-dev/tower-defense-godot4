extends Node


# Function to wrap an index around an array (circular array)
static func wrap_index(index: int, size: int) -> int:
	return ((index % size) + size) % size
