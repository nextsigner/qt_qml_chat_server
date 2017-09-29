#include "oc.h"

OC::OC(QObject *parent) : QObject(parent)
{



}

void OC::setClientWrapper(WebSocketClientWrapper *cw)
{
    clientWrapper = cw;
}
