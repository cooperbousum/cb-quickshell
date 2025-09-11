import QtQuick
import QtQuick.Effects
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower

Item {
  id: root
  property UPowerDevice battery: UPower.displayDevice
  anchors.horizontalCenter: parent.horizontalCenter

  Text {
    id: battery
    anchors.horizontalCenter: parent.horizontalCenter 
    text: Math.round(root.battery.percentage * 100) 

    color: {
      if (text > 20) {
        return "#ffffff"
      } else {
        return "#f28779"
      }
    }

    font.pointSize: 11
    font.family: "SF Mono"
  }

  Text {
    id: batteryIcon
    font.family: "FontAwesome" // Assuming Font Awesome is available
    font.pointSize: 14
    color: battery.color
    anchors.top: battery.bottom
    anchors.topMargin: 5
    anchors.horizontalCenter: parent.horizontalCenter

    // Dynamically choose icon based on percentage and charging state
    text: {
      var percentage = root.battery.percentage * 100
      if (!root.battery.isPresent) return "\uf059"; // fa-question-circle
      if (root.battery.changeRate > 0) {
          if (percentage >= 95) return ""; // fa-battery-full-solid
          if (percentage >= 75) return ""; // fa-battery-three-quarters
          if (percentage >= 50) return ""; // fa-battery-half
          if (percentage >= 25) return ""; // fa-battery-quarter
          return ""; // fa-battery-empty
      } else {
          if (percentage >= 95) return ""; // fa-battery-full
          if (percentage >= 75) return ""; // fa-battery-three-quarters
          if (percentage >= 50) return ""; // fa-battery-half
          if (percentage >= 25) return ""; // fa-battery-quarter
          return ""; // fa-battery-empty
      }
    }

    transform: Rotation {
      origin.x: batteryIcon.width / 2
      origin.y: batteryIcon.height / 2
      angle: 270
    }
  }

  Text {
    id: power
    property string inText
    anchors.top: batteryIcon.bottom
    anchors.topMargin: 7
    anchors.horizontalCenter: parent.horizontalCenter

    Process {
      id: powerProc
      command: ["/home/cooperbousum/.config/quickshell/cb/services/power.sh"]
      running: true
      stdout: StdioCollector {
        onStreamFinished: power.inText = this.text
      }
    }

    color: inText > 0 ? "#bae67e" : "#f28779"
    text: inText.slice(1)

    Timer {
      interval: 5000
      running: true
      repeat: true
      onTriggered: powerProc.running = true
    }
    font.pointSize: 11
    font.family: "SF Mono"
  }

}

