#ifndef MEMORY_H
#define MEMORY_H

#include "module.h"
#include <QGraphicsRectItem>
#include <QString>

class Memory : public Module,public QGraphicsRectItem
{
public:
    Memory();
    void drawshape();
    void setname(QString);
    QString getname();
    void write_memory_name();
    void set_parameters(double x,double y,double w = 150,double h = 200);
private:
    double x,y,width,height;
    QString name;
};

#endif // MEMORY_H
