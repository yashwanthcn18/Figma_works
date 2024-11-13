import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: qsTr("Animated Geometric Background")

    // Timer to trigger the screensaver clock after 5 seconds
    Timer {
        id: screensaverTimer
        interval: 5000  // 5 seconds
        repeat: false
        running: true  // Start the timer when the app launches
        onTriggered: {
            screensaverClockContainer.visible = true  // Show screensaver container
            timeUpdateTimer.start()  // Start updating the time
            logoImage.visible = false  // Hide the logo when screensaver is visible
        }
    }

    // Timer to update the time every second
    Timer {
        id: timeUpdateTimer
        interval: 1000  // 1 second
        repeat: true
        running: false
        onTriggered: {
            var currentDate = new Date()
            screensaverClock.text = Qt.formatTime(currentDate, "hh:mm AP")
            dateDisplay.text = Qt.formatDate(currentDate, "d MMMM yyyy | dddd")
        }
    }

    // Function to reset the timer on user activity
    function resetTimer() {
        screensaverClockContainer.visible = false  // Hide screensaver container
        timeUpdateTimer.stop()  // Stop updating the time
        screensaverTimer.restart()  // Restart the screensaver timer
        logoImage.visible = true  // Show the logo when screensaver is hidden
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#1a1a1a" }
            GradientStop { position: 1.0; color: "#0d0d0d" }
        }

        // Moving Rectangle 1
        Rectangle {
            width: parent.width / 2
            height: parent.height
            color: "#0a0a0a"
            opacity: 0.7
            rotation: 45
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            x: 0

            NumberAnimation on x {
                from: 0
                to: 50
                duration: 4000
                running: true
                loops: Animation.Infinite
                easing.type: Easing.InOutQuad
            }
        }

        // Moving Rectangle 2
        Rectangle {
            width: parent.width / 3
            height: parent.height
            color: "#1f1f1f"
            opacity: 0.7
            rotation: -45
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            y: 0

            NumberAnimation on y {
                from: 0
                to: 30
                duration: 5000
                running: true
                loops: Animation.Infinite
                easing.type: Easing.InOutQuad
            }
        }

        // Moving Rectangle 3
        Rectangle {
            width: parent.width / 1.5
            height: parent.height
            color: "#151515"
            opacity: 0.8
            rotation: 15
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            x: 0

            NumberAnimation on x {
                from: 0
                to: -40
                duration: 6000
                running: true
                loops: Animation.Infinite
                easing.type: Easing.InOutQuad
            }
        }
    }

    // Centered logo/image
    Image {
        id: logoImage
        source: "qrc:/logo.png"  // Replace with your logo image file
        anchors.centerIn: parent
        width: 200
        height: 200
    }

    // Screensaver Clock - initially hidden
    Column {
        id: screensaverClockContainer
        anchors.centerIn: parent
        visible: false  // Start hidden until screensaver timer triggers

        // Time display
        Text {
            id: screensaverClock
            font.pixelSize: 100  // Increase font size for the time
            color: "#F79422"  // Set to orange to match target UI
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: Qt.formatTime(new Date(), "hh:mm AP")
            font.family: "Monospace"
            font.bold: true
        }

        // Date display
        Text {
            id: dateDisplay
            font.pixelSize: 24  // Smaller font for the date
            color: "#666666"  // Gray color for the date
            anchors.horizontalCenter: screensaverClock.horizontalCenter //center under the time
            text: Qt.formatDate(new Date(), "d MMMM yyyy | dddd")
            font.family: "Monospace"
        }
    }

    // Capture user activity and reset screensaver timer
    MouseArea {
        anchors.fill: parent
        onClicked: resetTimer()
        onPressed: resetTimer()
    }
}
