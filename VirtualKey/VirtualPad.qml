import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
//import QtQuick.Controls.Material.impl 2.0
import QtGraphicalEffects 1.0

import "."

Canvas {
	id: control
	height: Units.dp * 64 * 3
	width: height

	property Item target: parent.target
	property var targetHandler: parent.targetHandler

	property bool deflectable: true
	property bool pressed
	property int repeatInterval: 33
	property int direction
	property int arrowSize: height/9
	property int innerRadius: (height-arrowSize*6)/2

	Material.elevation: pressed ? 8 : 2

	opacity: .7

	onPressedChanged: requestPaint()
	onDirectionChanged: requestPaint()

	onPaint: {
		var ctx = getContext("2d")
		ctx.save()
		ctx.clearRect(0, 0, width, height)

		ctx.beginPath()
		ctx.arc(height/2, width/2, height/2, 0, 2 * Math.PI)
		ctx.fillStyle = pressed?control.Material.buttonPressColor:control.Material.buttonColor
		ctx.fill()
		ctx.closePath()


		ctx.beginPath()
		ctx.arc(height/2, width/2, innerRadius, 0, 2 * Math.PI)
		ctx.strokeStyle = control.Material.primaryTextColor
		ctx.stroke()
		ctx.closePath()

		ctx.fillStyle = direction&4?
					control.Material.primaryHighlightedTextColor:
					control.Material.primaryTextColor

		ctx.beginPath()
		ctx.moveTo(arrowSize, height/2)
		ctx.lineTo(arrowSize*2, height/2-arrowSize)
		ctx.lineTo(arrowSize*2, height/2+arrowSize)
		ctx.fill()
		ctx.closePath()

		ctx.fillStyle = direction&1?
					control.Material.primaryHighlightedTextColor:
					control.Material.primaryTextColor

		ctx.beginPath()
		ctx.moveTo(width-arrowSize, height/2)
		ctx.lineTo(width-arrowSize*2, height/2-arrowSize)
		ctx.lineTo(width-arrowSize*2, height/2+arrowSize)
		ctx.fill()
		ctx.closePath()

		ctx.fillStyle = direction&2?
					control.Material.primaryHighlightedTextColor:
					control.Material.primaryTextColor

		ctx.beginPath()
		ctx.moveTo(width/2, arrowSize)
		ctx.lineTo(width/2-arrowSize, arrowSize*2)
		ctx.lineTo(width/2+arrowSize, arrowSize*2)
		ctx.fill()
		ctx.closePath()

		ctx.fillStyle = direction&8?
					control.Material.primaryHighlightedTextColor:
					control.Material.primaryTextColor

		ctx.beginPath()
		ctx.moveTo(width/2, height-arrowSize)
		ctx.lineTo(width/2-arrowSize, height-arrowSize*2)
		ctx.lineTo(width/2+arrowSize, height-arrowSize*2)
		ctx.fill()
		ctx.closePath()

		ctx.restore()
	}

	MouseArea {
		id: mouse
		anchors.fill: parent

		property int posX: width/2
		property int posY: height/2

		function calcDirection(x, y) {
			if (x === undefined) {
				x = posX
				y = posY
			}

			x -= width/2
			y -= height/2

			var dis = Math.sqrt(x*x+y*y)

			if (dis<innerRadius || dis*2>height) {
				return 0
			}

			if (deflectable) {
				if (Math.abs(x)>1.732*Math.abs(y))
					if (x>0)
						return 1 // right
					else
						return 4 // left
				else if (Math.abs(x)*1.732<Math.abs(y))
					if (y>0)
						return 8 // down
					else
						return 2 // up
				else
					return ((x>0)?1:4)|((y>0)?8:2)
			} else if (Math.abs(x)>Math.abs(y))
				if (x>0)
					return 1 // right
				else
					return 4 // left
			else if (y>0)
				return 8 // down
			else
				return 2 // up
		}

		onPressed: {
			posX = mouseX
			posY = mouseY
			control.pressed = true
			trigger.start()
		}

		onEntered: {
			posX = mouseX
			posY = mouseY
			control.pressed = true
			trigger.start()
		}

		onPositionChanged: {
			posX = mouseX
			posY = mouseY
		}

		onReleased: {
			trigger.stop()
			control.pressed = false
			control.direction = 0
		}

		onExited: {
			trigger.stop()
			control.pressed = false
			control.direction = 0
		}

		Timer {
			id: trigger
			interval: control.repeatInterval
			repeat: true

			onTriggered: {
				control.direction = mouse.calcDirection()
				if (control.direction)
					target.focus = true
				if (control.targetHandler) {
					if (control.direction & 1)
						control.targetHandler.rightPressed(InputEventSource.dummy)
					if (control.direction & 2)
						control.targetHandler.upPressed(InputEventSource.dummy)
					if (control.direction & 4)
						control.targetHandler.leftPressed(InputEventSource.dummy)
					if (control.direction & 8)
						control.targetHandler.downPressed(InputEventSource.dummy)
				} else {
					if (control.direction & 1)
						InputEventSource.keyPress(Qt.Key_Right, Qt.NoModifier, -1)
					if (control.direction & 2)
						InputEventSource.keyPress(Qt.Key_Up, Qt.NoModifier, -1)
					if (control.direction & 4)
						InputEventSource.keyPress(Qt.Key_Left, Qt.NoModifier, -1)
					if (control.direction & 8)
						InputEventSource.keyPress(Qt.Key_Down, Qt.NoModifier, -1)
				}
			}
		}
	}

	layer.enabled: true //control.Material.buttonColor.a > 0
////	layer.effect: ElevationEffect { // Not work ???
////		elevation: control.Material.elevation
////	}
	layer.effect: DropShadow {
		color: Qt.rgba(0,0,0,.2)
		radius: control.Material.elevation * 3
		spread: 0
		horizontalOffset: control.direction?
			(mouse.width/2 - mouse.mouseX) * Units.dp * 48 / mouse.width:
			0
		verticalOffset: control.direction?
			(mouse.height/2 - mouse.mouseY) * Units.dp * 48 / mouse.height:
			0
	}
}
