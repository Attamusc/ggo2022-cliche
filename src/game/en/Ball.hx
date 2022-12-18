package en;

class Ball extends Entity {
	var speed: Float = 0.8;

	public function new(x: Int, y: Int, angle: Float) {
		super(0, 0);

		setPosPixel(x, y);
		setPivots(0.5);

		wid = Const.GRID / 2;
		hei = Const.GRID / 2;

		var xSpeed = Math.cos(angle) * speed;
		var ySpeed = Math.sin(angle) * speed;

		v.dx = xSpeed;
		v.dy = ySpeed;
		v.setFricts(0.98, 0.98);

		spr.set(Assets.entities);
		spr.setCenterRatio(0.5, 0.5);
		spr.setScale(0.25);

		spr.anim.registerStateAnim("ball", 0, 1.0);
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
