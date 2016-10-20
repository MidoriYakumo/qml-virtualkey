import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
//import QtQuick.Controls.Material.impl 2.0
import QtGraphicalEffects 1.0

import "."

Item {
	id: control
	height: Units.gu * 3
	width: height

	property Item target: parent.target
	property var targetHandler: parent.targetHandler

	property bool enableAB: true
	property bool enableXY: true
	property int repeatInterval: 40
	property int buttonRadius: Units.gu * 1.4142 * 2 / 6

	property int keyA: Qt.Key_Z
	property int keyB: Qt.Key_X
	property int keyX: Qt.Key_A
	property int keyY: Qt.Key_S

	readonly property alias aPressed: d.aPressed
	readonly property alias bPressed: d.bPressed
	readonly property alias xPressed: d.xPressed
	readonly property alias yPressed: d.yPressed

	QtObject {
		id: d

		property int keys: 0
		property int prevKeys: 0

		property bool aPressed: keys&1
		property bool bPressed: keys&2
		property bool xPressed: keys&4
		property bool yPressed: keys&8
	}
	state: "freeze"

	states: [
		State {
			name: "freeze"
			PropertyChanges {
				target: repeatTrigger
				running: false
			}
		},
		State {
			name: "press"
			PropertyChanges {
				target: repeatTrigger
				running: true
				onTriggered: {
					mouse.key_release(d.prevKeys & ~d.keys)
					mouse.key_press(d.keys)
					d.prevKeys = d.keys
				}
			}
		},
		State {
			name: "release"
			PropertyChanges {
				target: repeatTrigger
				running: true
				onTriggered: {
					mouse.key_release(d.prevKeys)
					control.state = mouse.pressed?"press":"freeze"
				}
			}
		}
	]

	onAPressedChanged: buttonAB.requestPaint()
	onBPressedChanged: buttonAB.requestPaint()
	onXPressedChanged: buttonXY.requestPaint()
	onYPressedChanged: buttonXY.requestPaint()

	Canvas {
		id: buttonXY
		anchors.fill: parent

		Material.elevation: 2 + (xPressed + yPressed) * 3

		onPaint: {
			var dx = buttonRadius * 0.7071
			var ctx = getContext("2d")
			ctx.save()
			ctx.clearRect(0, 0, width, height)
			ctx.shadowColor = Qt.rgba(0,0,0,.24)
			ctx.shadowBlur = buttonRadius * 0.5

			ctx.beginPath()
			ctx.moveTo(width/6 + dx, height/2 + dx)
			ctx.lineTo(width/6 - dx, height/2 - dx)
			ctx.lineTo(width/2 - dx, height/6 - dx)
			ctx.lineTo(width/2 + dx, height/6 + dx)
			ctx.fillStyle = (control.xPressed&&control.yPressed)?
					Material.buttonPressColor:Material.buttonColor
			ctx.fill()
			ctx.closePath()

			ctx.beginPath()
			ctx.arc(width/6, height/2, buttonRadius, 0, 2 * Math.PI)
			ctx.fillStyle = xPressed?
						Material.buttonPressColor:Material.buttonColor
			ctx.fill()
			ctx.closePath()

			ctx.beginPath()
			ctx.arc(width/2, height/6, buttonRadius, 0, 2 * Math.PI)
			ctx.fillStyle = yPressed?
						Material.buttonPressColor:Material.buttonColor
			ctx.fill()
			ctx.closePath()

			ctx.restore()
		}

		layer.enabled: true //control.Material.buttonColor.a > 0
		layer.effect: DropShadow {
			color: Qt.rgba(0,0,0,.24)
			radius: buttonXY.Material.elevation * 1.5
			spread: buttonXY.Material.elevation * 0.02
			horizontalOffset: (control.yPressed - control.xPressed)*radius/4
			verticalOffset: -horizontalOffset
		}

		Behavior on Material.elevation {
			NumberAnimation {
				duration: 200
			}
		}
	}

	Canvas {
		id: buttonAB
		anchors.fill: parent

		Material.elevation: 2 + (aPressed + bPressed) * 3

		onPaint: {
			var dx = buttonRadius * 0.7071
			var ctx = getContext("2d")
			ctx.save()
			ctx.clearRect(0, 0, width, height)
			ctx.shadowColor = Qt.rgba(0,0,0,.24)
			ctx.shadowBlur = buttonRadius * 0.5

			ctx.beginPath()
			ctx.moveTo(width*5/6 + dx, height/2 + dx)
			ctx.lineTo(width*5/6 - dx, height/2 - dx)
			ctx.lineTo(width/2 - dx, height*5/6 - dx)
			ctx.lineTo(width/2 + dx, height*5/6 + dx)
			ctx.fillStyle = (control.aPressed&&control.bPressed)?
					Material.buttonPressColor:Material.buttonColor
			ctx.fill()
			ctx.closePath()

			ctx.beginPath()
			ctx.arc(width*5/6, height/2, buttonRadius, 0, 2 * Math.PI)
			ctx.fillStyle = bPressed?
						Material.buttonPressColor:Material.buttonColor
			ctx.fill()
			ctx.closePath()

			ctx.beginPath()
			ctx.arc(width/2, height*5/6, buttonRadius, 0, 2 * Math.PI)
			ctx.fillStyle = aPressed?
						Material.buttonPressColor:Material.buttonColor
			ctx.fill()
			ctx.closePath()
		}

		layer.enabled: true //control.Material.buttonColor.a > 0
		layer.effect: DropShadow {
			color: Qt.rgba(0,0,0,.24)
			radius: buttonAB.Material.elevation * 1.5
			spread: buttonAB.Material.elevation * 0.02
			horizontalOffset: (control.aPressed - control.bPressed)*radius/4
			verticalOffset: -horizontalOffset
		}

		Behavior on Material.elevation {
			NumberAnimation {
				duration: 200
			}
		}
	}

	MouseArea {
		id: mouse
		anchors.fill: parent

		function calcKeys(x, y) {
			function distance2(x0, y0, x1, y1) {
				return (x0-x1)*(x0-x1)+(y0-y1)*(y0-y1)
			}
			function cross(x0, y0, x1, y1, x2, y2) {
				return (x1-x0)*(y2-y0)-(x2-x0)*(y1-y0)
			}

			var r = 0
			var r2 = control.buttonRadius*control.buttonRadius
			if (distance2(x, y, width/2, height*5/6) <= r2) {
				r = 1
			} else if (distance2(x, y, width*5/6, height/2) <= r2) {
				r = 2
			} else if (distance2(x, y, width/6, height/2) <= r2) {
				r = 4
			} else if (distance2(x, y, width/2, height/6) <= r2) {
				r = 8
			} else {
				var ds = control.buttonRadius*width*1.4142/3
				var c0 = cross(x, y, width/2, height*5/6, width*5/6, height/2)
				var c1 = cross(x, y, width*5/6, height/2, width/2, height/6)
				var c2 = cross(x, y, width/2, height/6, width/6, height/2)
				var c3 = cross(x, y, width/6, height/2, width/2, height*5/6)

				if (c1*c3>0) {
					if (-ds<=c0 && c0 <= ds)
						r = 3
					else if (-ds<=c2 && c2 <= ds)
						r = 12
				}
			}
			return r
		}

		onPressed: {
			d.keys = calcKeys(mouseX, mouseY)
		}

		onPositionChanged: {
			d.keys = calcKeys(mouseX, mouseY)
		}

		onReleased: {
			d.keys = 0
		}
	}

	Timer {
		id: repeatTrigger
		interval: repeat?control.repeatInterval:0
		repeat: control.repeatInterval>0
		triggeredOnStart: true
	}
}
