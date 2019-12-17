#include "memory.h"
#include <QPen>
#include <QGraphicsTextItem>
#include <QGraphicsScene>

Memory::Memory()
{
    x = 0;
    y = 0;
    width = 150;
    height = 200;
    QPen pen(Qt::red);
    pen.setWidth(2);
    setPen(pen);
}

void Memory::drawshape()
{
    setRect(x,y,width,height);
}

void Memory::setname(QString a)
{
    name = a;
}

QString Memory::getname()
{
    return name;
}

void Memory::write_memory_name()
{
    QGraphicsTextItem* t = scene()->addText(name);
 //   t->setScale(2);
    t->setPos(15+x,30+y);
}

void Memory::set_parameters(double ax, double ay, double w, double h)
{
    width = w;
    height = h;
    x = ax;
    y = ay;
}
