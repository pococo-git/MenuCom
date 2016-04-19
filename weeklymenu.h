#ifndef WEEKLYMENU_H
#define WEEKLYMENU_H

#include <QObject>
#include <QDate>

class WeeklyMenu : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QDate date MEMBER m_date NOTIFY dateChanged)
    Q_PROPERTY(QString breakfast MEMBER m_breakfast NOTIFY breakfastChanged)
    Q_PROPERTY(QString lunch MEMBER m_lunch NOTIFY lunchChanged)
    Q_PROPERTY(QString dinner MEMBER m_dinner NOTIFY dinnerChanged)

public:
    explicit WeeklyMenu(QObject *parent = 0);


    QDate date() const;
    void setDate(const QDate &date);

    QString breakfast() const;
    void setBreakfast(const QString &breakfast);

    QString lunch() const;
    void setLunch(const QString &lunch);

    QString dinner() const;
    void setDinner(const QString &dinner);

signals:
    void dateChanged();
    void breakfastChanged();
    void lunchChanged();
    void dinnerChanged();

private:
    QDate m_date;
    QString m_breakfast;
    QString m_lunch;
    QString m_dinner;
};

#endif // WEEKLYMENU_H
