#include "weeklymenu.h"

WeeklyMenu::WeeklyMenu(QObject *parent) : QObject(parent)
{

}

QDate WeeklyMenu::date() const
{
    return m_date;
}

void WeeklyMenu::setDate(const QDate &date)
{
    m_date = date;
}

QString WeeklyMenu::breakfast() const
{
    return m_breakfast;
}

void WeeklyMenu::setBreakfast(const QString &breakfast)
{
    m_breakfast = breakfast;
}

QString WeeklyMenu::lunch() const
{
    return m_lunch;
}

void WeeklyMenu::setLunch(const QString &lunch)
{
    m_lunch = lunch;
}

QString WeeklyMenu::dinner() const
{
    return m_dinner;
}

void WeeklyMenu::setDinner(const QString &dinner)
{
    m_dinner = dinner;
}
