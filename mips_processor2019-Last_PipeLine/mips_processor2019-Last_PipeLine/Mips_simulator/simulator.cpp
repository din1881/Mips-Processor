#include "simulator.h"
#include <QFileDialog>
#include <QFile>
#include <QTextStream>
#include <QProcess>
#include <QDebug>
#include <QChar>
#include <math.h>
Simulator::Simulator()
{
    index = 0;
    button_open = new QPushButton;
    button_run = new QPushButton;
    button_cycle = new QPushButton;
    scene = new QGraphicsScene;
    setScene(scene);
    connect(button_open,SIGNAL(clicked()),this,SLOT(browse_assembly_file()));
    connect(button_run,SIGNAL(clicked()),this,SLOT(run_modelsim()));
    connect(button_cycle,SIGNAL(clicked()),this,SLOT(run_cycle()));
    Memory * IR = new  Memory;
    IR->set_parameters(-1250,-500,110,150);
    IR->setname("Instruct. Memory");
    IR->drawshape();
    scene->addItem(IR);
    IR->write_memory_name();
    Memory * pc = new Memory;
    pc->set_parameters(-1400,-475,55,75);
    pc->setname("PC");
    pc->drawshape();
    scene->addItem(pc);
    pc->write_memory_name();


    QPolygonF poly;
    poly << QPointF(-1345, -437) << QPointF(-1250, -437);
    QBrush brush;
    brush.setColor(Qt::black);
    brush.setStyle(Qt::SolidPattern);
    QPen pen(Qt::black);
    pen.setWidth(2);
    scene->addPolygon(poly,pen);


    QPolygonF poly2;
    poly2 << QPointF(-1140, -437) << QPointF(-1100, -437);
    QBrush brush2;
    brush2.setColor(Qt::black);
    brush2.setStyle(Qt::SolidPattern);
    QPen pen2(Qt::black);
    pen2.setWidth(2);
    scene->addPolygon(poly2,pen2);

    QPolygonF poly1;
    poly1 << QPointF(-1254, -440) << QPointF(-1250, -437);
    QBrush brush1;
    brush1.setColor(Qt::black);
    brush1.setStyle(Qt::SolidPattern);
    QPen pen1(Qt::black);
    pen1.setWidth(2);
    scene->addPolygon(poly1,pen1);

    QPolygonF poly3;
    poly3 << QPointF(-1254, -434) << QPointF(-1250, -437);
    QBrush brush3;
    brush3.setColor(Qt::black);
    brush3.setStyle(Qt::SolidPattern);
    QPen pen3(Qt::black);
    pen3.setWidth(2);
    scene->addPolygon(poly3,pen3);


    button_cycle->setGeometry(QRect(-1300,-600,100,30));
    button_cycle->setText("run cycle");
    scene->addWidget(button_cycle);
    button_run->setGeometry(QRect(-1100,-600,100,30));
    button_run->setText("run");
    scene->addWidget(button_run);
    button_open->setGeometry(QRect(-1500,-600,120,30));
    button_open->setText("open assembly file");
    scene->addWidget(button_open);
    QGraphicsTextItem * t = scene->addText("current pc");
    t->setPos(-1340, -460);
    t = scene->addText("Instruction register");
    t->setPos(-1135, -460);
}

unsigned int Simulator::convert_strbinto_int(QString a)
{
    unsigned int Current_pc = 0;
    for(int i = 0;i<a.length();i++)
    {
        if(a[i] == '1')
        {
            Current_pc += pow(2,a.length()- i - 1);
        }
    }
    return Current_pc;
}

unsigned int Simulator::convert_strtoint(QString a)
{
    unsigned int temp = 0;
    for(int i = 0;i<a.length();i++)
    {
       QChar ch = a.at(i);
       int x = ch.toLatin1();
       temp += pow(10,a.length()- i - 1) * (x-48);
    }
    return temp;
}

QString Simulator::strIntToHex(QString intStr)
{
       unsigned int  iTest = convert_strtoint(intStr);
       return QString("%1").arg(iTest & 0xFFFFFFFF, 8, 16);
}

void Simulator::run_modelsim()
{
    QString exePath = "C:/Windows/System32/cmd.exe";
    QString pc_file = "F:/project/Mips Processor/GUI/current_pc.txt";
    QString ir_file = "F:/Test_cases/machine code source/test5.txt";
    QString vsim = "vsim -c -do ";
    QString run = "\"run -all\"";
    QString mips_path = " C:/Modeltech_pe_edu_10.4a/examples/work.MIPS_cpu_single";
    QString modelsim_call = vsim + run + mips_path;
    QProcess consol;
    consol.start(exePath);
    consol.waitForStarted();
    consol.execute(modelsim_call);
    consol.close();
    QFile file(pc_file);
    if(!file.open(QIODevice::ReadOnly))
        return;
    QTextStream stream(&file);
    QString line;
    while(!stream.atEnd())
    {
        line = stream.readLine();
    }
    file.close();
    unsigned int out_sim = convert_strbinto_int(line);
    text_pc = scene->addText(QString::number(out_sim));
    text_pc->setPos(-1340, -440);
    QFile file1(ir_file);
    if(!file1.open(QIODevice::ReadOnly))
        return;
    QTextStream stream1(&file1);
    QString line1;
    while(!stream1.atEnd())
    {
        line1 = stream1.readLine();
    }
    file1.close();
    out_sim = convert_strbinto_int(line1);
    QString res = QString::number(out_sim);
    text_ir = scene->addText(strIntToHex(res));
    text_ir->setPos(-1135, -440);
}

void Simulator::run_cycle()
{
    if(text_pc != NULL && text_ir != NULL)
    {
        delete text_pc;
        delete text_ir;
    }
    unsigned int out_sim = 0;
    QString exePath = "C:/Windows/System32/cmd.exe";
    QString pc_file = "F:/project/Mips Processor/GUI/current_pc.txt";
    QString ir_file = "F:/Test_cases/machine code source/test5.txt";
    QString vsim = "vsim -c -do ";
    QString run = "\"run -all\"";
    QString mips_path = " C:/Modeltech_pe_edu_10.4a/examples/work.MIPS_cpu_single";
    QString modelsim_call = vsim + run + mips_path;
    if(index == 0)
    {
        QProcess consol;
        consol.start(exePath);
        consol.waitForStarted();
        consol.execute(modelsim_call);
        consol.close();
        QFile file(pc_file);
        if(!file.open(QIODevice::ReadOnly))
            return;
        QTextStream stream(&file);
        QString line;
        while (!stream.atEnd())
        {
            line = stream.readLine();
            lines.append(line);
        }
        file.close();
        QFile file1(ir_file);
        if(!file1.open(QIODevice::ReadOnly))
            return;
        QTextStream stream1(&file1);
        QString line1;
        while (!stream1.atEnd())
        {
            line1 = stream1.readLine();
            lines1.append(line1);
        }
        file1.close();
    }
    out_sim = convert_strbinto_int(lines[index]);
    text_pc = scene->addText(QString::number(out_sim));
    text_pc->setPos(-1340, -440);
    out_sim = convert_strbinto_int(lines1[index]);
    QString res = QString::number(out_sim);
    text_ir = scene->addText(strIntToHex(res));
    text_ir->setPos(-1135, -440);
    index++;
}

void Simulator::browse_assembly_file()
{
    QString filename = QFileDialog::getOpenFileName(this,tr("OPen File"),"F:/Test_cases/assembly_source","Text File (*.txt)");
}
