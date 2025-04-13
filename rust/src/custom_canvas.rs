use godot::classes::Node2D;
use godot::prelude::*;

#[derive(GodotClass)]
#[class(base=Node2D)]
struct CustomCanvas {
    tick: f64,
    base: Base<Node2D>,
    rng: rand::rngs::ThreadRng,
}

use godot::classes::INode2D;
use rand::Rng;

#[godot_api]
impl INode2D for CustomCanvas {
    fn init(base: Base<Node2D>) -> Self {
        godot_print!("custom canvas init!"); // Prints to the Godot console
        let rng = rand::rng();

        Self {
            rng,
            tick: 0.0,
            base,
        }
    }

    fn process(&mut self, delta: f64) {
        self.tick += delta;
        if self.tick > 2.0 {
            self.tick = 0.0;
            self.base_mut().queue_redraw();
        }
    }

    fn draw(&mut self) {
        let r = self.rng.random_range(0.0..1.0);
        let g = self.rng.random_range(0.0..1.0);
        let b = self.rng.random_range(0.0..1.0);
        self.base_mut().draw_rect(
            Rect2::from_components(0.0, 0.0, 100.0, 100.0),
            Color::from_rgba(r, g, b, 1.0),
        );
    }
}

#[godot_api]
impl CustomCanvas {}
