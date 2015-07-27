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


    Rectangle {
        id: gluten
        width: parent.width
        height: parent.height / 4
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 10
        color: backgroud_color

        Text{
            id: gluten_selet_title
            text: "First select batter type"
            font.bold: true
            font.pixelSize: 20
            color: "yellow"
        }

        ColumnLayout {
            id: gluten_column
            anchors.top: gluten_selet_title.bottom
            anchors.topMargin: 10

            ExclusiveGroup { id: gluten_sel_group }
            RadioButton {
                id: regular_button
                text: "Regular"
                checked: !m_selections.gluten_free
                exclusiveGroup: gluten_sel_group
                style: radio_button_style

                onClicked: {
                    m_selections.gluten_free = gluten_button.checked
                }
            }
            RadioButton {
                id: gluten_button
                text: "Gluten-free"
                checked: m_selections.gluten_free
                exclusiveGroup: gluten_sel_group
                style: radio_button_style

                onClicked: {
                    m_selections.gluten_free = gluten_button.checked
                }
            }
        }
    }

    Rectangle {
        id: crispy
        width: parent.width
        height: parent.height / 4
        anchors.top: gluten.bottom
        anchors.left: parent.left
        anchors.margins: 10
        color: backgroud_color

        Text{
            id: cripsy_selet_title

            text: "Then select how crispy"
            font.bold: true
            font.pixelSize: 20
            color: "yellow"
        }

        ColumnLayout {
            id: crispy_column
            anchors.top: cripsy_selet_title.bottom
            anchors.topMargin: 10

            ExclusiveGroup { id: cripsy_sel_group }
            RadioButton {
                id: regular
                text: "Regular"
                checked: !m_selections.extra_crispy
                exclusiveGroup: cripsy_sel_group
                style: radio_button_style

                onClicked: {
                    m_selections.extra_crispy = extra.checked
                }
            }
            RadioButton {
                id: extra
                text: "Extra crispy"
                exclusiveGroup: cripsy_sel_group
                checked: m_selections.extra_crispy
                style: radio_button_style

                onClicked: {
                    m_selections.extra_crispy = extra.checked
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
            id: welcome_image
            source: regular.checked ? "qrc:/images/plain.PNG" : "qrc:/images/crispy.PNG"
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
        }

    }

    function is_gluten_free()
    {
        return gluten_button.checked
    }

    function is_extra_crispy()
    {
        return extra.checked
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
