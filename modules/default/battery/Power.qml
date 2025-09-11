import QtQuick
import Quickshell.Io
import Quickshell
import Quickshell.Services.UPower

Item {
  id: root
  property UPowerDevice battery: UPower.displayDevice
  Text {
    id: power
    property string inText  
    property string outText
    anchors.verticalCenter: parent.verticalCenter

    Process {
      id: powerProc
      command: ["/home/cooperbousum/.config/quickshell/cb/services/power.sh"]
      running: true
      stdout: StdioCollector {
        onStreamFinished: power.inText = this.text
      }
    }

    color: { 
      if (inText < 0) {
        outText = inText.slice(1)
        return "#f28779"
      } else {
        outText = inText
        return "#bae67e"
      }
    }
    text: outText

    Timer {
      interval: 1500
      running: true
      repeat: true
      onTriggered: powerProc.running = true
    }
    font.pointSize: 11
    font.family: "SF Mono"
  }
}
