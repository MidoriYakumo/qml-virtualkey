
import QtQuick 2.7

import "."

MultiPointTouchArea {
	id: touch
	anchors.fill: target
	mouseEnabled: false

	property Item target: parent
	// enable for faster response but stick and drag while moving
	property bool stickAndDrag: false
	// perform drag on each point
	property bool simulateDrag: false
	// show ripple helper
	property bool touchVisualize: false

	TouchVisualRipple {
		id: ripple
	}

	InputEventDefer {
		id: defer
		pauseInput: !stickAndDrag
	}

	onPressed: {
		for (var i in touchPoints) {
			var p = touchPoints[i]
			if (touchVisualize)
				ripple.create(p.x, p.y, parent, "lime")

			defer.push({
				x:p.x, y:p.y,
				act: function(){
					target.focus = true
					InputEventSource.mousePress(target,
						this.x, this.y,
						Qt.LeftButton, Qt.NoModifier, -1
					)
				}
			})
		}

		defer.start()
	}

	onReleased: {
		for (var i in touchPoints) {
			var p = touchPoints[i]
			if (touchVisualize)
				ripple.create(p.x, p.y, parent, "slateblue")

			defer.push({
				x:p.x, y:p.y,
				act: function(){
					target.focus = true
					InputEventSource.mouseRelease(target,
						this.x, this.y,
						Qt.LeftButton, Qt.NoModifier, -1
					)
				}
			})
		}

		defer.start()
	}

	onUpdated: {
		for (var i in touchPoints) {
			var p = touchPoints[i]
			if (touchVisualize)
				ripple.create(p.x, p.y, parent, "teal")

			defer.push(simulateDrag?
				{
					x:p.x, y:p.y, px: p.previousX, py: p.previousY,
					act: function(){
						target.focus = true
						InputEventSource.mouseDrag(target,
							this.px, this.py, this.x, this.y,
							Qt.LeftButton, Qt.NoModifier, -1
						)
					}
				}:{
				   x:p.x, y:p.y,
				   act: function(){
					   target.focus = true
					   InputEventSource.mouseMove(target,
						   this.x, this.y, -1, Qt.LeftButton
					   )
				   }
				}
			)
		}

		defer.start()
	}

//	onCanceled: {
//		for (var i in touchPoints) {
//			var p = touchPoints[i]
//			if (touchVisualize)
//				ripple.create(p.x, p.y, parent, "crisom")

//			defer.push({
//				x:p.x, y:p.y,
//				act: function(){
//					target.focus = true
//					InputEventSource.mouseRelease(target,
//						this.x, this.y,
//						Qt.LeftButton, Qt.NoModifier, -1
//					)
//				}
//			})
//		}

//		defer.start()
//	}
}
