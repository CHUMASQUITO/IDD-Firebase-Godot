tool
extends Node2D

var minigameController = null;

export var zoneIndex = 0;
export var draggingZoneRadius = 50;
var zoneItem = null;

var zoneColor = Color.white;

func _on_Area2D_input_event(viewport, event, shape_idx):
	pass # Replace with function body.

func _process(delta):
	if (minigameController != null):
		var mousePosition = get_global_mouse_position();
		var mouseDistance = global_position.distance_to(mousePosition);

		if (mouseDistance < draggingZoneRadius):
			$Sprite.position = Vector2(-8, -16);
			$Sprite.rotation_degrees = -30;
		else:
			$Sprite.position = Vector2.ZERO;
			$Sprite.rotation_degrees = 0;
		
	update();

func _draw():
#	if Engine.editor_hint:
		draw_circle(Vector2.ZERO, draggingZoneRadius, Color.white);
