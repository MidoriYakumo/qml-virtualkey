import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
//import QtQuick.Controls.Material.impl 2.0
import QtGraphicalEffects 1.0

import "."

Canvas {
	id: control
	height: Units.gu * 3
	width: height

	property Item target: parent.target
	property var targetHandler: parent.targetHandler

	property bool enableAB: true
	property bool enableXY: true
	property int repeatInterval: 40
	property int buttonRadius: Units.gu * 1.4142 * 2 / 6

	property bool aPressed: false
	property bool bPressed: false
	property bool xPressed: false
	property bool yPressed: false

	property int keyA: Qt.Key_Z
	property int keyB: Qt.Key_X
	property int keyX: Qt.Key_A
	property int keyY: Qt.Key_S

	onPaint: {
		var dx = buttonRadius * 0.7071
		var ctx = getContext("2d")
		ctx.save()
		ctx.clearRect(0, 0, width, height)

		ctx.beginPath()
		ctx.moveTo(width/6 + dx, height/2 + dx)
		ctx.lineTo(width/6 - dx, height/2 - dx)
		ctx.lineTo(width/2 - dx, height/6 - dx)
		ctx.lineTo(width/2 + dx, height/6 + dx)
		ctx.fillStyle = control.Material.buttonPressColor
		ctx.fill()
		ctx.closePath()

		ctx.beginPath()
		ctx.arc(width/6, height/2, buttonRadius, 0, 2 * Math.PI)
		ctx.fillStyle = yPressed?control.Material.buttonPressColor:control.Material.buttonColor
		ctx.fill()
		ctx.closePath()

		ctx.beginPath()
		ctx.arc(width/2, height/6, buttonRadius, 0, 2 * Math.PI)
		ctx.fillStyle = control.Material.buttonPressColor
		ctx.fill()
		ctx.closePath()

		ctx.beginPath()
		ctx.moveTo(width*5/6 + dx, height/2 + dx)
		ctx.lineTo(width*5/6 - dx, height/2 - dx)
		ctx.lineTo(width/2 - dx, height*5/6 - dx)
		ctx.lineTo(width/2 + dx, height*5/6 + dx)
		ctx.fillStyle = control.Material.buttonPressColor
		ctx.fill()
		ctx.closePath()

		ctx.beginPath()
		ctx.arc(width*5/6, height/2, buttonRadius, 0, 2 * Math.PI)
		ctx.fillStyle = control.Material.buttonPressColor
		ctx.fill()
		ctx.closePath()

		ctx.beginPath()
		ctx.arc(width/2, height*5/6, buttonRadius, 0, 2 * Math.PI)
		ctx.fillStyle = control.Material.buttonPressColor
		ctx.fill()
		ctx.closePath()
	}

	MouseArea {
		id: mouse

		anchors.fill: parent
	}

	Timer {
		id: repeatTrigger

	}
}
