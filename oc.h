#ifndef OC_H
#define OC_H

#include <QObject>
#include "websocketclientwrapper.h"


class OC : public QObject
{
    Q_OBJECT
public:
    explicit OC(QObject *parent = nullptr);

signals:

public slots:
    void setClientWrapper(WebSocketClientWrapper *cw);
private:
    WebSocketClientWrapper *clientWrapper;
};

#endif // OC_H
