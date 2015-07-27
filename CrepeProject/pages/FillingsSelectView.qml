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
        id: fillings
        width: parent.width
        height: parent.height / 3
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 10
        color: backgroud_color

        Text{
            id: fillings_selet_title
            text: "What kind of fillings?"
            font.bold: true
            font.pixelSize: 20
            color: "yellow"
        }

        ColumnLayout {
            id: fillings_column
            anchors.top: fillings_selet_title.bottom
            anchors.topMargin: 10

            // checkbox
            CheckBox {
                id: wonton
                text: qsTr("Crispy wonton cracker (+ $0.50)")
                checked: m_selections.wonton
                style: checkbox_style

                onClicked: {
                    if (checked) {
                        no_fillings.checked = false;
                    }
                    else if (!hotdog.checked) {
                        no_fillings.checked = true;
                    }
                    preview_image.source = show_image();
                }
            }
            CheckBox {
                id: hotdog
                text: qsTr("All beef hotdog (+ $0.50)")
                checked: m_selections.hotdog
                style: checkbox_style

                onClicked: {
                    if (checked) {
                        no_fillings.checked = false;
                    }
                    else if (!wonton.checked) {
                        no_fillings.checked = true;
                    }

                    preview_image.source = show_image();
                }
            }

            CheckBox {
                id: no_fillings
                text: qsTr("No fillings (+ $0.00)")
                checked: !(m_selections.wonton || m_selections.hotdog)
                style: checkbox_style

                onClicked: {
                    if (checked) {
                        wonton.checked = false;
                        hotdog.checked = false;
                    }
                    else {
                        wonton.checked = true;
                        hotdog.checked = true;
                    }

                    preview_image.source = show_image();
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

    Text {
        id: no_worries
        text: "No worries, your veggies are on the other side"
        font.pixelSize: 20
        anchors.bottom: preview.top
        horizontalAlignment: Text.left
        color: "yellow"
    }

    Component.onCompleted: {
        show_image();
    }

    function is_wonton() {
        return wonton.checked;
    }

    function is_hotdog() {
        return hotdog.checked;
    }

    function update_selections() {
        m_selections.wonton = wonton.checked;
        m_selections.hotdog = hotdog.checked;
    }

    function show_image() {
        update_selections();
        if (no_fillings.checked) {
            if (m_selections.spicy) {
                m_image_name = m_selections.extra_crispy ?
                            "qrc:/images/crispy_spicy.PNG" : "qrc:/images/plain_spicy.PNG"
            }
            else {
                m_image_name = m_selections.extra_crispy ?
                            "qrc:/images/crispy_sweet.PNG" : "qrc:/images/plain_sweet.PNG"
            }
        }
        else if (wonton.checked) {
            if (hotdog.checked) {
                m_image_name =  m_selections.extra_crispy ?
                            (m_selections.spicy ?
                                 "qrc:/images/crispy_spicy_wok_hotdog.PNG" : "qrc:/images/crispy_sweet_wok_hotdog.PNG") :
                            (m_selections.spicy ?
                                 "qrc:/images/plain_spicy_wok_hotdog.PNG" : "qrc:/images/plain_sweet_wok_hotdog.PNG")

            }
            else {
                m_image_name = m_selections.extra_crispy ?
                            (m_selections.spicy ?
                                 "qrc:/images/crispy_spicy_wok.PNG" : "qrc:/images/crispy_sweet_wok.PNG") :
                            (m_selections.spicy ?
                                 "qrc:/images/plain_spicy_wok.PNG" : "qrc:/images/plain_sweet_wok.PNG")
            }
        }
        else {
            m_image_name = m_selections.extra_crispy ?
                        (m_selections.spicy ?
                             "qrc:/images/crispy_spicy_hotdog.PNG" : "qrc:/images/crispy_sweet_hotdog.PNG") :
                        (m_selections.spicy ?
                             "qrc:/images/plain_spicy_hotdog.PNG" : "qrc:/images/plain_sweet_hotdog.PNG")
        }

        return m_image_name;
    }

    Component {
        id: checkbox_style

        CheckBoxStyle {
            label: Text
            {
                text: control.text
                font.pixelSize: 20
                anchors.margins: 0
                horizontalAlignment: Text.left
                color: "yellow"
            }
        }
    }

}


