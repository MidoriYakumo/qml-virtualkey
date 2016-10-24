import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0

import "../VirtualKey"

Window {
	id: window
	objectName: "window"
	height: 600
	width: 600

	Flow {
		id: root
		objectName: "root"
		anchors.fill: parent

		padding: 8
		spacing: 8

		Button {
			id: b1
			objectName: "b1"
			text: objectName
		}

		Button {
			id: b2
			objectName: "b2"
			text: objectName
		}

		RadioButton {
			id: r1
			objectName: "r1"
			text: objectName
		}

		RadioButton {
			id: r2
			objectName: "r2"
			text: objectName
		}

		RadioButton {
			id: r3
			objectName: "r3"
			text: objectName
		}

		RangeSlider {
			id: s1
			objectName: "s1"
		}

		RangeSlider {
			id: s2
			objectName: "s2"
		}

		ButtonGroup {
			id: group
			buttons: [r1, r2, r3]
		}
	}

	Item {
		id: free
		objectName: "free"
		anchors.fill: parent

		Rectangle {
			id: o1
			objectName: "o1"
			height: 100
			width: height
			color: "khaki"
			x: 8
			y: parent.height - height - 8

			MouseArea {
				anchors.fill: parent
				drag.target: parent
			}
		}

		Rectangle {
			id: o2
			objectName: "o2"
			height: 100
			width: height
			color: "plum"
			x: parent.width - width - 8
			y: parent.height - height - 8

			MouseArea {
				anchors.fill: parent
				drag.target: parent
			}
		}
	}

	MutitouchDispatcher {
		enableVisualRipple: true
	}

//	MultiPointTouchArea {
//		id: touch
//		anchors.fill: parent
//		objectName: "input"

////		onCanceled: perform(touchPoints, event.mouseRelease, "crimson")
//		onPressed: perform(touchPoints, InputEventSource.mousePress, "lime")
//		onReleased: perform(touchPoints, InputEventSource.mouseRelease, "slateblue")
////		onTouchUpdated: perform(touchPoints, InputEventSource.mouseDoubleClick, "tomato")
//		onUpdated: perform(touchPoints, InputEventSource.mousePress, "teal")

//		onEnabledChanged: {
//			console.log("input.enabled:", enabled)
//		}

//		function perform(touchPoints, e, color) {
//			console.log(e.name, color)
//			console.log(touchPoints)
//			for (var i in touchPoints) {
//				var p = touchPoints[i]
//				var r = ripple.create(p.x, p.y, window, color)

//				defer.push({
//					x:p.x, y:p.y,
//					act: function(){
//						e(root, this.x, this.y, Qt.LeftButton, Qt.NoModifier, -1)
//					}
//				})
//			}

//			defer.start()
//		}

//		TouchVisualRipple {
//			id: ripple
//		}

//		InputEventDefer {
//			id: defer
//			input: touch
//		}
//	}
}
