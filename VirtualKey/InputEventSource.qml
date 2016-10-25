pragma Singleton

import QtTest 1.1

TestEvent {
	property var dummyKeyEvent

	property TestUtil util: TestUtil {

	}

	function mouseDrag(item, x, y, dx, dy, button, modifiers, delay) {
		mousePress(item, x, y, button, modifiers, delay)
		mouseMove(item, x + dx, y + dy, delay, button)
		mouseRelease(item, x + dx, y + dy, button, modifiers, delay)
//		// Divide dx and dy to have intermediate mouseMove while dragging
//		// Fractions of dx/dy need be superior to the dragThreshold
//		// to make the drag works though
//		var ddx = Math.round(dx/3)
//		if (ddx < (util.dragThreshold + 1))
//			ddx = 0
//		var ddy = Math.round(dy/3)
//		if (ddy < (util.dragThreshold + 1))
//			ddy = 0

//		mousePress(item, x, y, button, modifiers, delay)
//		//trigger dragging
//		mouseMove(item, x + util.dragThreshold + 1, y + util.dragThreshold + 1, delay, button)
//		if (ddx > 0 || ddy > 0) {
//			mouseMove(item, x + ddx, y + ddy, delay, button)
//			mouseMove(item, x + 2*ddx, y + 2*ddy, delay, button)
//		}
//		mouseMove(item, x + dx, y + dy, delay, button)
//		mouseRelease(item, x + dx, y + dy, button, modifiers, delay)
	}
}
