extends Node

@export var pipe_scene: PackedScene
var game_running : bool
var game_over : bool
var scroll
var score
const scroll_speed : int = 4
var screen_size : Vector2i
var ground_height : int
var pipes : Array
const pipe_delay : int = 100 
const pipe_range : int = 200



# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_window().size
	ground_height = $ground.get_node("Sprite2D").texture.get_height()
	new_game()

func new_game():
	#reset variables
	game_running = false
	game_over = false
	score = 0
	scroll = 0
	pipes.clear()
	#starting pipes
	generate_pipes()
	$nyan.reset()

func _input(event):
	if game_over == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if game_running == false:
					start_game()
				else:
					if $nyan.flying:
						$nyan.flap()

func start_game():
	game_running = true
	$nyan.flying = true
	$nyan.flap()
	#start pipe timer
	$pipe_timer.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_running:
		scroll += scroll_speed
		#reset scroll 
		if scroll >= screen_size.x:
			scroll = 0
		#move ground
		$ground.position.x = -scroll
		#move pipes
		for pipe in pipes:
			pipe.position.x -= scroll_speed


func _on_pipe_timer_timeout() -> void:
	generate_pipes()
	
func generate_pipes():
	var pipe = pipe_scene.instantiate()
	pipe.position.x = screen_size.x + pipe_delay
	@warning_ignore("integer_division")
	pipe.position.y = (screen_size.y - ground_height) / 2 + randi_range(-pipe_range, pipe_range)
	pipe.hit.connect(nyan_hit)
	add_child(pipe)
	pipes.append(pipe)

func nyan_hit():
	pass
