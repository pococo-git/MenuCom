#ifndef WEEKLYMENUMODEL_H
#define WEEKLYMENUMODEL_H

#include <QAbstractListModel>
#include <QList>
#include <QSharedPointer>
#include <QDate>

class WeeklyMenu;

class WeeklyMenuModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QString filePath READ filePath WRITE setFilePath NOTIFY filePathChanged)
    Q_PROPERTY(bool importFlag READ importFlag WRITE setImportFlag NOTIFY importFlagChanged)
    Q_PROPERTY(bool uploadFlag READ uploadFlag WRITE setUploadFlag NOTIFY uploadFlagChanged)
public:
    explicit WeeklyMenuModel(QObject *parent = 0);
    ~WeeklyMenuModel();

    enum WeeklyMenuRole {
        DateRole = Qt::UserRole + 1,
        BreakfastRole,
        LunchRole,
        DinnerRole
    };

    // UIから呼ばれる
    Q_INVOKABLE QVariant get(int row) const;
    Q_INVOKABLE bool sync();

    bool importFlag() const;
    void setImportFlag(bool import);
    bool uploadFlag() const;
    void setUploadFlag(bool upload);
    QString filePath() const;
    void setFilePath(const QString &filePath);

signals:
    void importFlagChanged();
    void uploadFlagChanged();
    void filePathChanged();

public slots:
    // UIから呼ばれる
    void appendRow(QDate date, const QString &breakfast, const QString &lunch, const QString &dinner);
    void updateRow(int row, QDate date, const QString &breakfast, const QString &lunch, const QString &dinner);
    void removeRow(int row);

private:
    // メンバ
    QList<QSharedPointer<WeeklyMenu> > m_list;
    void sortRows();
    bool dataImport();
    bool dataUpload();
    bool m_import;
    bool m_upload;
    QString m_filePath;

// QAbstractItemModel interface
public:
    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

};

#endif // WEEKLYMENUMODEL_H
