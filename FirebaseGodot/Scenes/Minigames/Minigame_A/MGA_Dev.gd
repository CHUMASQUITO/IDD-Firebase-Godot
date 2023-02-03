extends Node2D

var devInitialYPosition = Vector2(0, 0);
var devTargetYPosition = Vector2(0, 0);

export(Curve) var devEnterAnimationCurve;
var devEnterAnimationPosition = 0;
var devEnterAnimationTime = 1;
var devEnterAnimationCurrentTime = 0;

var devEnterAnimationCurveValue = 0;

func _ready():
	$DraggingZones.visible = false;
	
	devEnterAnimationPosition = devEnterAnimationCurrentTime/devEnterAnimationTime;
	devEnterAnimationCurveValue = self.devEnterAnimationCurve.interpolate(devEnterAnimationPosition);
	position = lerp(devInitialYPosition, devTargetYPosition, devEnterAnimationCurveValue);
	
func _process(delta):
	if (devEnterAnimationCurrentTime < devEnterAnimationTime):
		devEnterAnimationCurrentTime += delta;
	else:
		if !$DraggingZones.visible:
			$DraggingZones.visible = true;
				
	devEnterAnimationPosition = devEnterAnimationCurrentTime/devEnterAnimationTime;
	devEnterAnimationCurveValue = self.devEnterAnimationCurve.interpolate(devEnterAnimationPosition);
	position = lerp(devInitialYPosition, devTargetYPosition, devEnterAnimationCurveValue);
