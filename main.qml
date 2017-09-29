import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import Qt.WebSockets 1.0
//import ObjectC11 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("qt_qml_chat_server by nextsigner")
    property var ocw: cw
    //    OC{
    //        id: oc
    //    }
    Connections {
        target: cw
        onClientConnected:{
            console.log("Cliente conectado!!!!!")
            //cw.usersList
        }

    }
    Connections {
        target: cs
        onUserListChanged:{
            console.log("Cliente Count 1 : "+cs.userList)
            listModelUser.updateUserList()
        }
        onNewMessage:{
                listModelMsg.addMsg(msg)
        }
    }
    Row{
        anchors.fill: parent
        Rectangle{
            width: parent.width*0.7
            height: parent.height
            border.width: 1
            Rectangle{
                width: parent.width
                height: 28
                color: "black"
                Text {
                    text: "<b>Messages</b>"
                    font.pixelSize: 24
                    anchors.centerIn: parent
                    color: "white"
                }
            }
            ListView{id:msgListView;width: parent.width; height: parent.height-28; y:28; spacing: 10; model: listModelMsg; delegate: delegateMsg;}
        }
        Rectangle{
            width: parent.width*0.3
            height: parent.height
            border.width: 1
            Rectangle{
                width: parent.width
                height: 28
                color: "black"
                Text {
                    text: "<b>User List</b>"
                    font.pixelSize: 24
                    anchors.centerIn: parent
                    color: "white"
                }
            }
            ListView{id:userListView;width: parent.width; height: parent.height-28; y:28; spacing: 10; model: listModelUser; delegate: delegateUser;}
        }
    }

    ListModel{
        id: listModelUser
        function createElement(u){
            return {
                user: u
            }
        }
        function updateUserList(){
            clear()
            var ul = cs.userList;
            for(var i=0; i < ul.length; i++){
                append(createElement(ul[i]))
            }
        }
    }
    ListModel{
        id: listModelMsg
        function createElement(m){
            return {
                msg: m
            }
        }
        function addMsg(msg){
             append(createElement(msg))
        }
    }
    Component{
        id: delegateUser
        Rectangle{
            width: userListView.width*0.9
            height: 24
            border.width: 1
            color: "#cccccc"
            radius: height*0.25
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                text: "<b>"+user+"</b>"
                font.pixelSize: 20
                anchors.centerIn: parent
            }
        }
    }
    Component{
        id: delegateMsg
        Rectangle{
            width: msgListView.width*0.9
            height: txtMsg.contentHeight
            border.width: 1
            color: "#cccccc"
            radius: height*0.25
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                id: txtMsg
                width: parent.width-48
                height: contentHeight
                text: "<b>"+msg+"</b>"
                font.pixelSize: 20
                anchors.centerIn: parent
                wrapMode: Text.WordWrap
            }
        }
    }
    Component.onCompleted: {
            listModelUser.updateUserList()
    }


}
