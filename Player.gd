extends Area2D

var screen_size
export var speed = 400

func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite.position = Vector2(200, 600)
	$AnimatedSprite.show()
	$AnimatedSprite.play()

func _process(delta):
	var velocity = Vector2()
	var key_pressed = false
	
	if Input.is_action_pressed("ui_right"):
		key_pressed = true
		velocity.x += 1;
		
	if Input.is_action_pressed("ui_left"):
		key_pressed = true
		velocity.x -= 1;
		
	if !key_pressed:
		$AnimatedSprite.animation = "win"
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	print(position)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
		
func _on_AnimatedSprite_frame_changed():
	var collision: RectangleShape2D = $CollisionShape2D.shape
	var frameSize = $AnimatedSprite.frames.get_frame(
		$AnimatedSprite.animation, 
		$AnimatedSprite.frame
	).get_size()
	collision.extents = frameSize
	print(collision.extents)
