tool
extends Node2D

var minigameController = null;

export(MinigamesEnums.MGA_ZONE_TYPE) var draggingZoneType;
export var draggingZoneRadius = 50;

var draggingZoneInMouse = false;

var draggingZoneObject = null;
var draggingZoneColor = Color.white;

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
	if Engine.editor_hint:
		draw_circle(Vector2.ZERO, draggingZoneRadius, draggingZoneColor);
#	else:
#		if draggingZoneInMouse:
#			zoneAngle = 30 + 5 * sin(degtorad(current_time));
#			zoneXOffset = - (8 + 2 * sin(degtorad(current_time)));
#			zoneYOffset = - (16 + 2 * sin(degtorad(current_time)));
#			zoneAlpha = 1;
#		else:
#			if (devZoneObject == noone):
#				zoneAngle = 0;
#				zoneXOffset = 0;
#				zoneYOffset = 0;
#				zoneAlpha = 1;
#			else:
#				zoneAngle = 0;
#				zoneXOffset = 8;
#				zoneYOffset = 8;
#				zoneAlpha = 0;
#
#		draw_sprite_ext(spr_MGA_Spot, 0, x + zoneXOffset, y + zoneYOffset, 1, 1, zoneAngle, devZoneColor, 1);
#		draw_sprite_ext(spr_MGA_Spot, 1, x + zoneXOffset, y + zoneYOffset, 1, 1, zoneAngle, c_white, zoneAlpha);
