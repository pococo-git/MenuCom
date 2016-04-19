#include "weeklymenumodel.h"
#include "weeklymenu.h"
#include <QHash>
#include <QMap>
#include <QDebug>
#include <QFile>
#include <QDir>
#include <QUrl>

// データホルダ
//class WeeklyMenu {
//    public:
//        QDate date;
//        QString breakfast;
//        QString lunch;
//        QString dinner;
//};

// コンストラクタ/デストラクタ
WeeklyMenuModel::WeeklyMenuModel(QObject *parent)
    : QAbstractListModel(parent)
    , m_import(false)
    , m_upload(false)
{
}

WeeklyMenuModel::~WeeklyMenuModel()
{
    m_list.clear();
}

QVariant WeeklyMenuModel::get(int row) const
{
    if (row < 0 || row >= m_list.size()) {
        return QVariant();
    }

    QMap<QString, QVariant> result;
    const QHash<int, QByteArray>& roles = roleNames();
    QHash<int, QByteArray>::const_iterator it;
    for (it = roles.begin(); it != roles.end(); it++) {
        result[it.value()] = data(index(row), it.key());
    }

    return result;
}

bool WeeklyMenuModel::uploadFlag() const
{
    return m_upload;
}

void WeeklyMenuModel::setUploadFlag(bool upload)
{
    if (m_upload == upload)
        return;

    m_upload = upload;
    emit uploadFlagChanged();
}

bool WeeklyMenuModel::importFlag() const
{
    return m_import;
}

void WeeklyMenuModel::setImportFlag(bool import)
{
    if (m_import == import)
        return;

    m_import = import;
    emit importFlagChanged();
}

bool WeeklyMenuModel::sync()
{
    qDebug() << "WeeklyMenuModel::sync() :" << m_upload << m_import << m_filePath;
    bool ret = false;
    if (m_upload) {
        ret = dataUpload();
        setUploadFlag(false);
    } else if (m_import) {
        ret = dataImport();
        setImportFlag(false);
    }

    return ret;
}

bool WeeklyMenuModel::dataImport()
{
    qDebug() << "WeeklyMenuModel::DataImport()";
    if (m_list.size() != 0) {
        beginRemoveRows(QModelIndex(), 0, m_list.size());
        m_list.clear();
        endRemoveRows();
    }

    QFile f(m_filePath);
    if (!f.exists()) {
        qWarning() << "Don't exist for Weekly Menu File [" << f.fileName() << "]";
        return false;
    }

    if (!f.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Don't open for Weekly Menu File [" << f.fileName() << "]";
        return false;
    }

    while (!f.atEnd()) {
        QString line = f.readLine().simplified();
        qDebug() << "Read Line :" << line;
        QStringList list = line.split(",");
        qDebug() << list;
        appendRow(QDate::fromString(list.at(0), "yyyy/MM/dd"), list.at(1), list.at(2), list.at(3));
    }

    return true;
}

bool WeeklyMenuModel::dataUpload()
{
    if (m_list.size() == 0) {
        return false;
    }

    QFile f(m_filePath);
    if (!f.open(QIODevice::WriteOnly | QIODevice::Text)) {
        qWarning() << "Don't open for Weekly Menu File [" << f.fileName() << "]";
        return false;
    }

    QTextStream st(&f);
    for (int i = 0; i < m_list.size(); i++) {
        QSharedPointer<WeeklyMenu> wm = m_list.at(i);
        st << wm->date().toString("yyyy/MM/dd") << ", "
           << wm->breakfast() << ", "
           << wm->lunch() << ", "
           << wm->dinner() << "\n";
    }
    f.close();
    return true;
}

QString WeeklyMenuModel::filePath() const
{
    return m_filePath;
}

void WeeklyMenuModel::setFilePath(const QString &filePath)
{
    if (filePath.contains("file://")) {
        m_filePath = QUrl(filePath).toLocalFile();
    } else {
        m_filePath = filePath;
    }
    emit filePathChanged();
}

void WeeklyMenuModel::appendRow(
        QDate date,
        const QString &breakfast,
        const QString &lunch,
        const QString &dinner)
{
    QSharedPointer<WeeklyMenu> wm(new WeeklyMenu);
    wm->setDate(date);
    wm->setBreakfast(breakfast);
    wm->setLunch(lunch);
    wm->setDinner(dinner);

    beginInsertRows(QModelIndex(), m_list.size(), m_list.size());
    m_list.append(wm);
    endInsertRows();
    sortRows();
}

void WeeklyMenuModel::updateRow(
        int row,
        QDate date,
        const QString &breakfast,
        const QString &lunch,
        const QString &dinner)
{
    if (row < 0 || row >= m_list.size()) {
        return;
    }
    QSharedPointer<WeeklyMenu> &wm = m_list[row];
    wm->setDate(date);
    wm->setBreakfast(breakfast);
    wm->setLunch(lunch);
    wm->setDinner(dinner);
    emit dataChanged(index(row), index(row));
}

void WeeklyMenuModel::removeRow(int row)
{
    if (row < 0 || row >= m_list.size()) {
        return;
    }
    beginRemoveRows(QModelIndex(), row, row);
    m_list.removeAt(row);
    endRemoveRows();
}

// ソートを実現するprivate関数
void WeeklyMenuModel::sortRows()
{
    if (m_list.size() == 0) {
        return;
    }
    std::sort(m_list.begin(), m_list.end(), [&] (const QSharedPointer<WeeklyMenu> &left, const QSharedPointer<WeeklyMenu> &right) {
        bool result = left->date() < right->date();
        return result;
    });
    emit dataChanged(index(0), index(m_list.size() - 1));
}

int WeeklyMenuModel::rowCount(const QModelIndex &) const
{
    return m_list.size();
}

QVariant WeeklyMenuModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= m_list.size()) {
        return QVariant();
    }
    const QSharedPointer<WeeklyMenu> &data = m_list[index.row()];
    switch (role) {
    case DateRole:
        return data->date();
    case BreakfastRole:
        return data->breakfast();
    case LunchRole:
        return data->lunch();
    case DinnerRole:
        return data->dinner();
    }
    return QVariant();
}

QHash<int, QByteArray> WeeklyMenuModel::roleNames() const
{
    static QHash<int, QByteArray> roleNames;
    if (roleNames.size() == 0) {
        roleNames.insert(DateRole, "date");
        roleNames.insert(BreakfastRole, "breakfast");
        roleNames.insert(LunchRole, "lunch");
        roleNames.insert(DinnerRole, "dinner");
    }
    return roleNames;
}
