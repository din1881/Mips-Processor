#ifndef ARROW_H
#define ARROW_H

#include <QGraphicsLineItem>
#include <QGraphicsPolygonItem>
#include <QGraphicsLineItem>
#include <QGraphicsScene>
#include <QRectF>
#include <QGraphicsSceneMouseEvent>
#include <QPainterPath>
#include "module.h"

class Arrow : public QGraphicsLineItem
{
public:
    Arrow(Module*,Module*);
    QRectF boundingRect() const;
    QPainterPath shape() const;
    void setColor(const QColor &mycolor);
    Module * startItem();
    Module * endItem();
    void paint_arrow(QGraphicsScene * scene);
private:
    QPolygonF arrowHead;
    QColor color;
    Module *start_module;
    Module *end_module;
};

#endif
