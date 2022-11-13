package en;

class Ball extends Entity {
	var speed: Float = 2.;

	public function new(x: Int, y: Int, angle: Float) {
		super(0, 0);

		setPosPixel(x, y);
		setPivots(0.5);

		var xSpeed = Math.cos(angle) * speed;
		var ySpeed = Math.sin(angle) * speed;

		v.dx = xSpeed;
		v.dy = ySpeed;

		v.setFricts(0.98, 0.98);

		var b = new h2d.Bitmap(h2d.Tile.fromColor(Red, M.round(iwid / 2), M.round(ihei / 2)), spr);
		b.tile.setCenterRatio(x, y);
	}

	override function onPreStepX() {
		super.onPreStepX();

		if (xr > 0.9 && level.hasCollision(cx + 1, cy)) {
			xr = 0.9;
			v.dx = -v.dx;
		}

		if (xr < 0.1 && level.hasCollision(cx - 1, cy)) {
			xr = 0.1;
			v.dx = -v.dx;
		}
	}

	override function onPreStepY() {
		super.onPreStepY();

		if (yr > 0.9 && level.hasCollision(cx, cy + 1)) {
			yr = 0.9;
			v.dy = -v.dy;
		}

		if (yr < 0.1 && level.hasCollision(cx, cy - 1)) {
			yr = 0.1;
			v.dy = -v.dy;
		}
	}

	override function onTouchEntity(e: Entity) {
		if (e.is(en.Goal)) {
			destroy();
		}
	}
}
