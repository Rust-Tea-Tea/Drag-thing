extends StaticBody2D
#Dummy object that follows the mouse and acts as one end of the pin
@onready var pin_joint: PinJoint2D = $Pin
var dragged_body: RigidBody2D = null

func _process(_delta):
	global_position = get_global_mouse_position()
#Pinning the physics object on click 
func _input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var body = _get_body_under_mouse()
			if body is RigidBody2D:
				dragged_body = body
				pin_joint.node_b = dragged_body.get_path()
		else:
			pin_joint.node_b = ""
			dragged_body = null
#Getting the object to pin
#Forgot how I did it before so ended up asking ai for getting the object under the click
#Not 100% sure what it did here frankly, never saw direct_space_state used ever before
func _get_body_under_mouse() -> Node:
	var space = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	query.collide_with_areas = true  
	var result = space.intersect_point(query)
	for hit in result:
		if hit.collider is RigidBody2D:
			return hit.collider
	return null
#Ai changed other stuff too but most of that makes sense to me
