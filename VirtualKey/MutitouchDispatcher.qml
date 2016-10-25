
import QtQuick 2.7

import "."

MultiPointTouchArea {
	id: touch
	anchors.fill: target

	property Item target: parent
	property bool enableDragSimulate: false
	property bool enableVisualRipple: false

	TouchVisualRipple {
		id: ripple
	}

	InputEventDefer {
		id: defer
	}

	onPressed: {
		for (var i in touchPoints) {
			var p = touchPoints[i]
			if (enableVisualRipple)
				ripple.create(p.x, p.y, parent, "lime")

			defer.push({
				x:p.x, y:p.y,
				act: function(){
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
			if (enableVisualRipple)
				ripple.create(p.x, p.y, parent, "slateblue")

			defer.push({
				x:p.x, y:p.y,
				act: function(){
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
			if (enableVisualRipple)
				ripple.create(p.x, p.y, parent, "teal")

			defer.push(enableDragSimulate?
				{
					x:p.x, y:p.y, px: p.previousX, py: p.previousY,
					act: function(){
						InputEventSource.mouseDrag(target,
							this.px, this.py, this.x-this.px, this.y-this.py,
							Qt.LeftButton, Qt.NoModifier, -1
						)
					}
				}:{
				   x:p.x, y:p.y,
				   act: function(){
					   InputEventSource.mouseMove(target,
						   this.x, this.y,
						   Qt.LeftButton, Qt.NoModifier, -1
					   )
				   }
				}
			)
		}

		defer.start()
	}
}
