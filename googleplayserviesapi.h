#ifndef GOOGLEPLAYSERVIESAPI_H
#define GOOGLEPLAYSERVIESAPI_H

#include <QObject>

class GooglePlayServiesApi : public QObject
{
    Q_OBJECT

public:
    explicit GooglePlayServiesApi(QObject *parent = nullptr);
    Q_INVOKABLE bool login();
signals:

public slots:
};

#endif // GOOGLEPLAYSERVIESAPI_H
