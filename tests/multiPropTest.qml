import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0

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


	MultiPointTouchArea {
		id: input
		anchors.fill: parent
		objectName: "input"

//		property var eventBlock: ({})
		property var tpStore

//		onCanceled: perform(touchPoints, event.mouseRelease, "crimson")
		onPressed: perform(touchPoints, event.mousePress, "lime")
		onReleased: perform(touchPoints, event.mouseRelease, "slateblue")
//		onTouchUpdated: perform(touchPoints, event.mouseDoubleClick, "tomato")
		onUpdated: perform(touchPoints, event.mousePress, "teal")

		onEnabledChanged: {
			console.log("input.enabled:", enabled)
			if (enabled) {
//				updateTouchData(touchPoints)
//				console.log(touchPoints.length) // == 0
//				for (var i in tpStore) {
//					console.log(tpStore[i].x)
//					var tpi = tp.createObject(input)
//					tpStore[i] = tpi
//					console.log(tpStore[i].x, tpi)
//				}
//				touchPoints = tpStore
//				console.log(tpStore, touchPoints)
			}
		}

		function perform(touchPoints, e, color) {
//			if (eventBlock[e.name])
//				return;
//			eventBlock[e.name] = true
			console.log(e.name, color)
			console.log(touchPoints)
			tpStore = []
			for (var i in touchPoints) {
				var p = touchPoints[i]
				var t = ({})
				for (var q in p)
					t[q] = p[q]
				tpStore.push(t)
				var r = ripple.createObject(window)
				r.cx = p.x
				r.cy = p.y
				r.color = color

				defer.queue.push({
					x:p.x, y:p.y,
					act: function(){
						e(root, this.x, this.y)
					}
				})
			}

			enabled = false
			defer.start()
		}

		Component {
			id: tp

			TouchPoint { }
		}

	}

	TestCase {
		id: event
	}

	Timer {
		id: defer

		interval: 100

		property var queue: []

		onTriggered: {
			var i = 0
			while (queue.length) {
				var q = queue.shift()
				console.log(i++, q.x, q.y)
				q.act()
			}
			input.enabled = true
//			for (var e in input.eventBlock) {
//				input.eventBlock[e] = false
//			}
		}
	}

	Component {
		id: ripple

		Rectangle {
			property int cx
			property int cy
			property int size: 64

			width: 1
			height: width
			radius: width
			x: cx-width/2
			y: cy-height/2
			opacity: (1-(width/size))*.7
			color: "skyblue"

			Behavior on width {
				NumberAnimation {
					duration: 1000
				}
			}

			onOpacityChanged: {
				if (opacity <= 0)
					destroy()
			}

			Component.onCompleted: {
				width = size + 1
			}
		}
	}

}
