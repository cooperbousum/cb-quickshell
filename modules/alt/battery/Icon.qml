import QtQuick
import Quickshell.Io
import Quickshell
import Quickshell.Services.UPower

Item {
  id: root
  property UPowerDevice battery: UPower.displayDevice
  property color color
  Text {
    id: batteryIcon
    font.family: "FontAwesome" // Assuming Font Awesome is available
    font.pointSize: 16
    anchors.verticalCenter: parent.verticalCenter
    anchors.leftMargin: 8
    color: root.color

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
  }
}
