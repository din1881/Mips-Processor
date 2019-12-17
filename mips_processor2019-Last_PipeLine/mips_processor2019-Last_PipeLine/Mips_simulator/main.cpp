#include<QGraphicsView>
#include <QGraphicsScene>
#include<QGraphicsRectItem>
#include <QApplication>
#include <QPushButton>
#include "simulator.h"
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    Simulator * sim = new Simulator();
 //   sim->resize(1000,500);
    sim->show();
 /* QPolygonF poly;
    poly << QPointF(10, 10) << QPointF(10, 50);// << QPointF(30, 70 )<< QPointF(60, 50) << QPointF(50, 10);
    QBrush brush;
    brush.setColor(Qt::red);
    brush.setStyle(Qt::SolidPattern);
    QPen pen(Qt::blue);
    pen.setWidth(5);
    scene->addPolygon(poly,pen);*/

    /*QGraphicsRectItem * rect = new QGraphicsRectItem();
    rect->setRect(50,50,100,100);
    scene->addItem(rect);*/


    return a.exec();
}
