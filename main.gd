extends Node

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
	new_game()

func new_game():
	#reset variables
	game_running = false
	game_over = false
	score = 0
	scroll = 0
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



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_running:
		scroll += scroll_speed
		#reset scroll 
		if scroll >= screen_size.x:
			scroll = 0
		#move ground
		$ground.position.x = -scroll
