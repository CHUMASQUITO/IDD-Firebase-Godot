extends Node2D

var minigameController = null;

var elementIndex = 0;
var elementSelected = false;
var elementDraggOffset = Vector2.ZERO;

func _on_Area2D_input_event(viewport, event, shape_idx):
	#Hacer click en un elemento
	if (Input.is_action_just_pressed("leftClick")):
		if (minigameController != null):
			#Seleccionar elemento si no hay ninguno
			if (minigameController.draggingElement == null):
				_selectElement();
			else:
				#Seleccionar elemento con z index mayor si hay varios elementos superpuestos (y deseleccionar los de z index menor)
				if (z_index > minigameController.draggingElement.z_index):
					minigameController.draggingElement._deselectElement();
					_selectElement();

func _process(delta):
	#Mover elemento a la posición del mouse
	if (elementSelected):
		position = get_global_mouse_position() + elementDraggOffset;

		#Soltar elemento
		if (Input.is_action_just_released("leftClick")):
			if (minigameController != null):
				if (minigameController.draggingElement != null):
					_deselectElement();
					
					for i in minigameController.draggingZonesArray.size():
						var currentDraggingZone = minigameController.draggingZonesArray[i];
						if (position.distance_to(currentDraggingZone.position) < 50):
							position = currentDraggingZone.position;

func _selectElement():
	minigameController.draggingElement = self;
	elementSelected = true;
	elementDraggOffset = (position - get_global_mouse_position());

func _deselectElement():
	minigameController.draggingElement = null;
	elementSelected = false;
	elementDraggOffset = Vector2.ZERO;

func _dropElementInZone(zoneNode):
	pass;
