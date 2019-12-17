#ifndef SIMULATOR_H
#define SIMULATOR_H

#include <QGraphicsView>
#include <QGraphicsScene>
#include <QGraphicsRectItem>
#include <QPushButton>
#include <QResizeEvent>
#include <QGraphicsTextItem>
#include <QObject>
#include <QList>
#include "memory.h"
#include "arrow.h"

class Simulator : public QGraphicsView
{
    Q_OBJECT
public:
    Simulator();
    unsigned int convert_strbinto_int(QString a);
    unsigned int convert_strtoint(QString a);
    QString strIntToHex(QString intStr);
    QGraphicsScene* scene;
    QPushButton * button_open;
    QPushButton * button_run;
    QPushButton * button_cycle;
    QList<QString> lines;
    QList<QString> lines1;
private slots:
      void browse_assembly_file();
      void run_modelsim();
      void run_cycle();

private:
      int index;
      QGraphicsTextItem* text_pc;
      QGraphicsTextItem* text_ir;

};

#endif // SIMULATOR_H
