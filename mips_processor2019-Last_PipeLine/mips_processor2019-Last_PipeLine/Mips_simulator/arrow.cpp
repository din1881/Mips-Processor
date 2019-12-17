#include <QtGui>

#include "arrow.h"
#include <math.h>
const qreal Pi = 3.14;

Arrow::Arrow(Module *start,Module *end)
{
    start_module = start;
    end_module = end;
    color = Qt::black;
    setPen(QPen(color,2,Qt::SolidLine,Qt::RoundCap,Qt::RoundJoin));
}

QRectF Arrow::boundingRect() const
{
    qreal extra = (pen().width()+20)/2.0;
    return QRectF(line().p1(),QSizeF(line().p2().x() - line().p1().x(),line().p2().y()-line().p1().y()))
    .normalized()
    .adjusted(-extra,-extra,extra,extra);
}

QPainterPath Arrow::shape() const
{
    QPainterPath path = QGraphicsLineItem::shape();
    path.addPolygon(arrowHead);
    return path;
}

void Arrow::setColor(const QColor &mycolor)
{
    color = mycolor;
}

Module *Arrow::startItem()
{
    return start_module;
}

Module *Arrow::endItem()
{
    return end_module;
}

void Arrow::paint_arrow(QGraphicsScene * scene)
{

    qreal x1,x2,y;
    x1 = start_module->get_data_inputs()+1;
    x2 = 200/(end_module->get_data_inputs()+1);
    y = 75;
    QPolygonF poly;
    poly << QPointF(250, y) << QPointF(150, y);
    QBrush brush;
    brush.setColor(Qt::black);
    brush.setStyle(Qt::SolidPattern);
    QPen pen(Qt::black);
    pen.setWidth(3);
    scene->addPolygon(poly,pen);
  /*  QBrush brush;
    brush.setColor(Qt::black);
    QPen pen(Qt::black);
    pen.setWidth(4);
    scene->addPolygon(poly,pen);*/
}


