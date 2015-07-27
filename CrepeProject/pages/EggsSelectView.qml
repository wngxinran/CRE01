import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.1
// Grid Layout
import QtQuick.Layouts 1.1

Item {

    property color backgroud_color: "transparent"

    // default users selections
    property var m_selections: { 'gluten_free':   false,
                                 'extra_crispy':  false,
                                 'number_of_eggs': 1,
                                 'onion':         true,
                                 'cilantro':      true,
                                 'sesame':        true,
                                 'wonton':        true,
                                 'hotdog':        true,
                                 'sweet':         false,
                                 'spicy':         true

    }

    property string m_image_name

    Rectangle {
        id: eggs
        width: parent.width
        height: parent.height / 4
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 10
        color: backgroud_color

        Text{
            id: eggs_selet_title
            text: "How many eggs?"
            font.bold: true
            font.pixelSize: 20
            color: "yellow"
        }

        ColumnLayout {
            id: eggs_column
            anchors.top: eggs_selet_title.bottom
            anchors.topMargin: 10

            ExclusiveGroup { id: eggs_sel_group }

            RadioButton {
                id: egg_0
                text: "0 (- $0.50)"
                checked: m_selections.number_of_eggs === 0
                exclusiveGroup: eggs_sel_group
                style: radio_button_style

                onClicked: {
                    preview_image.source = show_image()
                }
            }
            RadioButton {
                id: egg_1
                text: "1 (+ $0.00)"
                checked: m_selections.number_of_eggs === 1
                exclusiveGroup: eggs_sel_group
                style: radio_button_style

                onClicked: {
                    preview_image.source = show_image()
                }
            }
            RadioButton {
                id: egg_2
                text: "2 (+ $0.50)"
                checked: m_selections.number_of_eggs === 2
                exclusiveGroup: eggs_sel_group
                style: radio_button_style

                onClicked: {
                    preview_image.source = show_image()
                }
            }
        }
    }

    Rectangle {
        id: preview
        width: parent.width
        height: parent.height / 2
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        Image {
            id: preview_image
            source: m_image_name
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
        }
    }

    Component.onCompleted: {
        show_image();
    }

    function update_selections() {
        m_selections.number_of_eggs = egg_0.checked ?
                    0 : (egg_1.checked ? 1 : 2);
    }

    function show_image() {
        update_selections();
        if (m_selections.number_of_eggs === 0) {
            m_image_name = m_selections.extra_crispy ?
                        "qrc:/images/crispy.PNG" : "qrc:/images/plain.PNG";
        }
        else if (m_selections.number_of_eggs === 1) {
            m_image_name =  m_selections.extra_crispy ?
                        "qrc:/images/crispy_1_egg.PNG" : "qrc:/images/plain_1_egg.PNG";
        }
        else if(m_selections.number_of_eggs === 2) {
            m_image_name  =  m_selections.extra_crispy ?
                        "qrc:/images/crispy_2_eggs.PNG" : "qrc:/images/plain_2_eggs.PNG";
        }

        return m_image_name;
    }

    function number_of_eggs() {
        if (egg_0.checked)
            return 0;
        return egg_1.checked ? 1 : 2;
    }

    Component {
        id: radio_button_style

        RadioButtonStyle {
            label: Text
            {
                text: control.text
                font.pixelSize: 20
                anchors.margins: 0
                horizontalAlignment: Text.left
                color: "yellow"
            }

            indicator: Rectangle {
                implicitWidth: 16
                implicitHeight: 16
                radius: 9
                border.color: control.activeFocus ? "darkblue" : "gray"
                border.width: 1
                Rectangle {
                    anchors.fill: parent
                    visible: control.checked
                    color: "#555"
                    radius: 9
                    anchors.margins: 4
                }
            }
        }
    }

}


