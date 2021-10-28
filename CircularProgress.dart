import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class _CircularProgress extends CustomPainter {
  final StrokeCap strokecap;
  final Color forenground;
  final Color background;
  final double percent;
  final double linePercentWidth;
  final double lineCircleWidth;
  final double insize;

  _CircularProgress({
    this.percent = 0.0,
    this.strokecap = StrokeCap.round,
    this.forenground = Colors.green,
    this.background = Colors.grey,
    this.linePercentWidth = 10,
    this.lineCircleWidth = 10,
    this.insize = 100,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint circle = Paint()
      ..strokeWidth = lineCircleWidth
      ..color = background
      ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width / 2, size.height / 2); //center
    double radius = insize;
    canvas.drawCircle(center, radius, circle);

    // I will draw animation

    Paint animationArc = Paint()
      ..strokeWidth = linePercentWidth
      ..color = forenground
      ..style = PaintingStyle.stroke
      ..strokeCap = strokecap;
    double angle = 2 * pi * (percent / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), pi / 2,
        angle, false, animationArc);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RadialChart extends StatefulWidget {
  final double infill;
  final StrokeCap strokecap;
  final Color forenground;
  final Color background;
  final Color colorFont;
  final double percent;
  final double insize;
  final double linePercentWidth;
  final double lineCircleWidth;

  final double fontsize;

  RadialChart({
    Key? key,
    this.percent = 0.0,
    this.strokecap = StrokeCap.round,
    this.forenground = Colors.green,
    this.background = Colors.grey,
    this.colorFont = Colors.black,
    this.linePercentWidth = 10,
    this.lineCircleWidth = 10,
    this.infill = 0.0,
    this.insize = 100,
    this.fontsize = 58,
  }) : super(key: key);

  @override
  _RadialChartState createState() => _RadialChartState();
}

class _RadialChartState extends State<RadialChart> {
  double maxprogress = 20;

  RegExp regexstart = RegExp('[^.]*');
  RegExp regexend = RegExp('\.[^.]*\$');

  @override
  Widget build(BuildContext contex) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomPaint(
                foregroundPainter: _CircularProgress(
                  background: widget.background,
                  forenground: widget.forenground,
                  strokecap: widget.strokecap,
                  lineCircleWidth: widget.lineCircleWidth,
                  linePercentWidth: widget.linePercentWidth,
                  insize: widget.insize,
                  percent: widget.percent,
                ),
                child: Container(
                  width: 200,
                  height: 200,
                  margin: EdgeInsets.all(10),
                  child: Center(
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: (() {
                            if (regexstart
                                    .stringMatch(widget.percent.toString()) !=
                                '0') {
                              print(regexstart.stringMatch(
                                  widget.percent.toStringAsFixed(1)));
                              return regexstart.stringMatch(
                                  widget.percent.toStringAsFixed(2));
                            } else {
                              return '00';
                            }
                          }()),
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: widget.colorFont,
                            fontSize: widget.fontsize,
                            inherit: false,
                          ),
                        ),
                        TextSpan(
                          text: (() {
                            if (regexend
                                    .stringMatch(widget.percent.toString()) !=
                                '0') {
                              return '${regexend.stringMatch(widget.percent.toStringAsFixed(2))}%';
                            }
                          }()),
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: widget.colorFont,
                            fontSize: widget.fontsize / 2,
                            inherit: false,
                          ),
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
