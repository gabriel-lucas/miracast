import QtQuick 2.4
import QtQuick.Window 2.2
import Ubuntu.Components 1.3

Page {

    header: PageHeader {
        id: pageHeader
        title: i18n.tr("Mircast")
        leadingActionBar.actions : [
            Action{
                iconSource: "../graphics/mircast.png"
            }
        ]
    }

    onFocusChanged: {
        if(!screenHeight.text) {
            screenHeight.text = Screen.height/ 2;
        }
        if(!screenWidth.text) {
            screenWidth.text = Screen.width / 2;
        }
    }

    Column {
        id:settingsColumn
        enabled:!launcher.active
        anchors {
            top: pageHeader.bottom
            left:parent.left
            right:parent.right
            topMargin: units.gu(5)
        }
        height:units.gu(15)
        spacing: units.gu(3)

        Row {
            id:connectionSettingssRow
            anchors {
                horizontalCenter: parent.horizontalCenter
                topMargin: units.gu(2)
            }
            width:parent.width
            spacing: units.gu(3)

            TextField {
                id: remoteIp
                width:parent.width/2 - parent.spacing
                objectName: "remoteIp"
                placeholderText: i18n.tr("Remote IP / hostname")
                text:mircastSettings.remoteIP
            }

            TextField {
                id: portNumber
                visible:false
                objectName: "portNumber"
                placeholderText: i18n.tr("Remote port number")
                text:"12345"
            }
            Column {
                Label {
                    id:compressionLabel
                    text: i18n.tr("Compression") + ":"
                }
                Slider {
                    id:compression
                    width:connectionSettingssRow.width/2 - (connectionSettingssRow.spacing)
                    maximumValue: 9
                    minimumValue: 1
                    value: mircastSettings.compression
                    onValueChanged: {
                        mircastSettings.compression = launcher.compression = value;
                    }
                }
            }
        }
        Row {
            id:screenSettingsRow

            anchors {
                horizontalCenter: parent.horizontalCenter
                topMargin: units.gu(2)
            }
            width:parent.width
            spacing: units.gu(3)

            TextField {
                id: screenWidth
                width:parent.width/2 - parent.spacing
                objectName: "screenWidth"
                placeholderText: i18n.tr("Width")
                text:mircastSettings.screenWidth

            }

            TextField {
                id: screenHeight
                width:parent.width/2- parent.spacing
                objectName: "screenHeight"
                placeholderText: i18n.tr("Height")
                text:mircastSettings.screenHeight
            }
        }
    }
    Column {
        anchors {
            left:parent.left
            right:parent.right
            top:settingsColumn.bottom
            margins: units.gu(1)
        }
        spacing: units.gu(1)

        DeviceInstructions {
            anchors {
                left:parent.left
                right:parent.right
                margins: units.gu(1)
            }
        }

        TextArea {
            id:outputLog
            anchors {
                left:parent.left
                right:parent.right
                margins: units.gu(2)
            }
            readOnly: true
            text: launcher.output
        }
    }

    Button {
        id:castButton
        objectName: "button"
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom:parent.bottom
            margins: units.gu(1)
        }
        width: parent.width
        height:units.gu(5)
        enabled: !launcher.active
        text: launcher.active ? i18n.tr("Close the app to stop the cast") :i18n.tr("Cast")

        onClicked: {
            if(launcher.active) {
                launcher.stop();
            } else {
                mircastSettings.remoteIP = launcher.remoteIP = remoteIp.text;
                mircastSettings.screenWidth = launcher.width = screenWidth.text;
                mircastSettings.screenHeight = launcher.height = screenHeight.text;
                launcher.cast();
            }
        }
    }

}
