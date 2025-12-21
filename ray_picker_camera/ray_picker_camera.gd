extends Camera3D

# Exported variables
@export var ray_length := 100.0
@export var turret_manager: TurretManager

# Onready variables
@onready var ray_cast_3d: RayCast3D = $RayCast3D

# Built-in methods
func _process(_delta: float) -> void:
	var mouse_position := get_viewport().get_mouse_position()
	ray_cast_3d.target_position = project_local_ray_normal(mouse_position) * ray_length
	ray_cast_3d.force_raycast_update()

	if ray_cast_3d.get_collider() is GridMap:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		if Input.is_action_just_pressed("click"):
			_handle_grid_click()
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)

# Private methods
func _handle_grid_click() -> void:
	var col_position := ray_cast_3d.get_collision_point()
	var grid_map := ray_cast_3d.get_collider() as GridMap
	var cell := grid_map.local_to_map(grid_map.to_local(col_position))

	if grid_map.get_cell_item(cell) == 0:
		grid_map.set_cell_item(cell, 1)
		var tile_position := grid_map.map_to_local(cell)
		turret_manager.build_turret(tile_position)
		
