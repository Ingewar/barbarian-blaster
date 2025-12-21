# Godot Project Guidelines

## Script Structure

All Godot scripts should follow this consistent structure for better readability and maintainability:

```gdscript
# 1. EXTENDS (class inheritance)
extends Node3D

# 2. CLASS_NAME (optional - for reusable components)
class_name PlayerController

# 3. DOCUMENTATION COMMENT (optional but recommended)
## A brief description of what this script does.
## Use double ## for doc comments that appear in the editor.

# 4. SIGNALS
signal health_changed(new_health: int)
signal died()
signal item_collected(item: Node)

# 5. ENUMS
enum State {
	IDLE,
	MOVING,
	ATTACKING
}

# 6. CONSTANTS
const MAX_SPEED := 100.0
const GRAVITY := 9.8

# 7. EXPORTED VARIABLES (grouped by category)
@export_category("Movement")
@export var speed := 5.0
@export var jump_height := 10.0

@export_category("Combat")
@export var max_health := 100
@export var damage := 10

# 8. PUBLIC VARIABLES
var current_state := State.IDLE
var velocity := Vector3.ZERO

# 9. PRIVATE VARIABLES (prefix with _)
var _is_attacking := false
var _combo_count := 0

# 10. ONREADY VARIABLES (nodes and resources)
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite3D = $Sprite3D
@onready var collision_shape: CollisionShape3D = $CollisionShape3D

# 11. BUILT-IN VIRTUAL METHODS (in Godot lifecycle order)
func _init() -> void:
	pass

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	pass

# 12. PUBLIC METHODS (alphabetically or by logical grouping)
func take_damage(amount: int) -> void:
	pass

func heal(amount: int) -> void:
	pass

func attack() -> void:
	pass

# 13. PRIVATE METHODS (prefix with _, alphabetically or by logical grouping)
func _update_animation() -> void:
	pass

func _calculate_velocity(delta: float) -> Vector3:
	return Vector3.ZERO

# 14. SIGNAL CALLBACKS (at the end, prefixed with _on_)
func _on_hurt_box_damage_received(amount: int) -> void:
	take_damage(amount)

func _on_animation_player_animation_finished(anim_name: String) -> void:
	pass

func _on_area_3d_body_entered(body: Node3D) -> void:
	pass
```

## Key Principles

### Type Hints
- Always use type hints for variables: `var health: int = 100`
- Always specify return types: `func move() -> void`
- This improves autocomplete and catches errors at edit-time

### Naming Conventions
- **Private methods/variables**: Prefix with underscore `_private_method()`
- **Signal callbacks**: Prefix with `_on_` and follow pattern `_on_[node_name]_[signal_name]`
- **Constants**: Use UPPER_SNAKE_CASE `const MAX_HEALTH := 100`
- **Variables/functions**: Use snake_case `var player_speed := 5.0`
- **Classes**: Use PascalCase `class_name PlayerController`

### Signal Callbacks
- Place all signal callback functions at the bottom of the script
- Use the naming pattern: `_on_[node_name]_[signal_name]`
- Example: `func _on_hurt_box_damage_received(amount: int) -> void:`

### @onready Variables
- Order matters - variables initialize top-to-bottom
- If one @onready var references another, order by dependency
- Always type hint node references: `@onready var player: CharacterBody3D = $Player`

### Export Variables
- Use `@export_category()` to group related exports
- Use `:=` for type inference when the type is obvious
- Order: most important/frequently modified properties first

### Comments
- Use `##` for documentation comments (appear in editor tooltips)
- Use `#` for implementation notes
- Avoid obvious comments - code should be self-documenting

## Collision System Naming

### HurtBox
- Area that **receives** damage
- Alternative names: DamageReceiver, VulnerableArea, HealthCollider
- Should call a damage method on its parent (e.g., `take_damage()`)

### HitBox
- Area that **deals** damage
- Alternative names: DamageDealer, AttackArea, WeaponCollider
- Contains damage value and deals it to HurtBoxes

### Pattern
```gdscript
# Entity that receives damage
@onready var hurtbox: HurtBox = $HurtBox

# Entity that deals damage (projectile, weapon)
@onready var hitbox: HitBox = $HitBox
```

### Collision Layers
- Separate hitboxes and hurtboxes on different layers
- Example:
  - Layer 1: Player hurtboxes
  - Layer 2: Enemy hurtboxes
  - Layer 3: Player hitboxes (mask: Layer 2)
  - Layer 4: Enemy hitboxes (mask: Layer 1)

## Best Practices

1. **One responsibility per script** - Keep scripts focused on a single purpose
2. **Signals over direct calls** - Use signals for loose coupling between nodes
3. **Prefer composition** - Use child nodes and components over inheritance
4. **Type everything** - Enable static typing in Project Settings
5. **No magic numbers** - Use named constants instead of raw values
6. **Early returns** - Reduce nesting with guard clauses
7. **Consistent spacing** - Use blank lines to separate logical sections
