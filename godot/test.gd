extends Node2D


func _on_button_pressed() -> void:
	$Player.increase_speed(10.0)
	pass # Replace with function body.


func _on_player_speed_increased() -> void:
	print("speed_increased received")
	pass # Replace with function body.


var playback # Will hold the AudioStreamGeneratorPlayback.
@onready var sample_hz = $AudioStreamPlayer.stream.mix_rate
var pulse_hz = 440.0 # The frequency of the sound wave.
var phase = 0.0

var rng = RandomNumberGenerator.new()

func _ready():
	$AudioStreamPlayer.play()
	playback = $AudioStreamPlayer.get_stream_playback()
	fill_buffer()

func fill_buffer():
	var increment = pulse_hz / sample_hz
	var frames_available = playback.get_frames_available()

	for i in range(frames_available):
		playback.push_frame(Vector2.ONE * sin(phase * TAU))
		phase = fmod(phase + increment, 1.0)

func _process(delta: float) -> void:
	fill_buffer();
	
func _on_button_play_pressed() -> void:
	pulse_hz = rng.randf_range(130.8, 987.8)
	print("pulse changed %s" % pulse_hz)

func _on_player_pulse_chage_request() -> void:
	pulse_hz = rng.randf_range(130.8, 987.8)
	print("pulse changed auto %s" % pulse_hz)
	pass # Replace with function body.
