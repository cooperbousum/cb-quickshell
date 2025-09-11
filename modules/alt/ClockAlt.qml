import "../../services"
import QtQuick
import QtQuick.Effects
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell
import Quickshell.Io

  Text {
    id: clock
    color: "#ffffff"

    property string displayTime: {
      var hour = Time.format("hh") % 12;
      if (hour === 0) {
        hour = 12;
      } else if (hour < 10) {
        hour = "0" + hour;
      }
      var min = Time.format("mm");
      return hour + ":" + min;
    }
    
    text: displayTime
    font.pointSize: 12
    font.family: "SF Mono"
    
  }


