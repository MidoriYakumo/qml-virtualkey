import QtQuick 2.7
import QtQuick.Controls 2.0

import VirtualKey 1.0

Rectangle {
	id: scene
	width: 800
	height: 600
	focus: true
	color: "teal"

	Rectangle {
		id: ground

		anchors.bottom: scene.bottom
		width: scene.width
		height: Math.min(Math.max(scene.height/3, Units.gu * 2), Units.gu * 6)
		color: "coral"
	}

	Rectangle {
		id: player

		property real speedX: 0
		property real speedY: 0
		property real speedR: speedX / Units.dp
		property real bottomY: ground.y
		property bool onTheGround: bottomY >= ground.y - .5

		y: bottomY - height * (0.5 + 0.7071 *
							   Math.max(Math.abs(Math.cos((45-rotation) * Math.PI / 180)),
							   Math.abs(Math.cos((rotation-135) * Math.PI / 180))
							  ))

		antialiasing: true
		height: Units.gu
		width: height
		color: "white"

		Behavior on speedX {
			NumberAnimation {
				duration: 300
			}
		}

		NumberAnimation {
			id: rotate
			target: player
			property: "rotation"
		}

		function getNearest(deg) {
			for (var i=0;i<=4;i++) {
				if (Math.abs(90 * i + deg - rotation)<=45)
					return 90 * i + deg
			}
			return deg
		}
	}

	Timer {
		id: fs
		interval: 16
		repeat: true
		running: true

		onTriggered: {
			player.x += player.speedX
			if (player.x >= scene.width - player.width * 1.2) {
				player.x = scene.width - player.width * 1.2
				player.speedX = 0
			}
			if (player.x <= player.width * .3) {
				player.x = player.width * .3
				player.speedX = 0
			}

			if (player.speedY != 0) {
				player.bottomY += player.speedY
				if (player.speedY>0 && player.onTheGround) {
					player.bottomY = ground.y
					player.speedY = 0
				} else {
					player.speedY += Units.dp / 1e2 * interval
				}
			}

			player.rotation = (360 + player.rotation + player.speedR) % 360
		}
	}

	Keys.onPressed: {
		switch (event.key) {
		case Qt.Key_Left:
			if (player.onTheGround)
				player.speedX = -Units.dp * 20
			break
		case Qt.Key_Right:
			if (player.onTheGround)
				player.speedX = Units.dp * 20
			break
		case Qt.Key_Up:
			if (player.onTheGround) {
				player.speedY = -Units.dp * 9
			}
			break
		case Qt.Key_Down:
			if (!player.onTheGround) {
				player.speedY = Units.dp * 19
				rotate.duration = 100
				rotate.to = player.getNearest(45)
				rotate.restart()
			}
			break
		}
	}

	Keys.onReleased: {
		switch (event.key) {
		case Qt.Key_Left:
			player.speedX = 0
			rotate.duration = 500
			rotate.to = player.getNearest(0)
			rotate.restart()
			break
		case Qt.Key_Right:
			player.speedX = 0
			rotate.duration = 500
			rotate.to = player.getNearest(0)
			rotate.restart()
			break
		}
	}
}
