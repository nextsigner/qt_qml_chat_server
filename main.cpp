/*
Este código ha sido creado por nextsigner@gmail.com
Es un proyecto de Aplicación Demo para comprender el funcionamiento de QWebChannel.
Este código ha sido descargado de https:/github.com/nextsignger/qt_qml_chat_server.git

Its code was created by nextsigner@gmail.com
Its a project of Demo Application for understand the functions of QWebChannel.
This code was downloaded of https:/github.com/nextsignger/qt_qml_chat_server.git
*/
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "qwebchannel.h"
#include "chatserver.h"

#include "websocketclientwrapper.h"
#include "websockettransport.h"

#include <QtWebSockets/QWebSocketServer>


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);


    QWebSocketServer server(QStringLiteral("QWebChannel Standalone Example Server"),
                            QWebSocketServer::NonSecureMode);
    if (!server.listen(QHostAddress::LocalHost, 12345)) {
        qFatal("Failed to open web socket server.");
        return 1;
    }

    // wrap WebSocket clients in QWebChannelAbstractTransport objects
    WebSocketClientWrapper clientWrapper(&server);

    // setup the channel
    QWebChannel channel;
    QObject::connect(&clientWrapper, &WebSocketClientWrapper::clientConnected,
                     &channel, &QWebChannel::connectTo);

    // setup the dialog and publish it to the QWebChannel
    ChatServer* chatserver = new ChatServer(&app);
    channel.registerObject(QStringLiteral("chatserver"), chatserver);


    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("cs", chatserver);
    engine.rootContext()->setContextProperty("cw", &clientWrapper);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
