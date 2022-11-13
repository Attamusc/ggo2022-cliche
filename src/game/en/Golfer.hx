package en;

import hxd.Window;
import h2d.col.RoundRect;

class Golfer extends Entity {
	var ca: ControllerAccess<GameAction>;
	var currentBall: Ball;

	var rotationSpeed: Float = 0.5;

	public function angToMouse(?offX = 0, ?offY = 0) {
		return Math.atan2(App.ME.mouseY - centerY + offY, App.ME.mouseX - centerX + offX);
	}

	public function new() {
		super(0, 0);
		setPivots(0.5);

		// Starting point using level entity "PlayerStart"
		var start = level.data.l_Entities.all_PlayerStart[0];
		if (start != null) {
			setPosCase(start.cx, start.cy);
		}

		camera.trackEntity(this, true);
		camera.clampToLevelBounds = true;

		// Init controller
		ca = App.ME.controller.createAccess();
		ca.lockCondition = Game.isGameControllerLocked;

		// Placeholder display of a blue rectangle
		var b = new h2d.Bitmap(h2d.Tile.fromColor(Blue, iwid, ihei), spr);
		b.tile.setCenterRatio(start.pivotX, start.pivotY);
	}

	override function dispose() {
		super.dispose();
		ca.dispose();
	}

	override function preUpdate() {
		super.preUpdate();
	}

	override function postUpdate() {
		super.postUpdate();

		// keyboard-based character rotation
		if (ca.getAnalogDist2(MoveLeft, MoveRight) > 0) {
			spr.rotate(ca.getAnalogValue2(MoveLeft, MoveRight) * rotationSpeed);
		}

		var facingAngle = angToMouse();
		spr.rotation = facingAngle;

		if (ca.isPressed(Swing)) {
			if (currentBall != null) {
				currentBall.destroy();
				currentBall = null;
			}

			currentBall = new Ball(M.round(centerX), M.round(centerY), facingAngle);
		}
	}
}
