import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = min(centerX, centerY);

    Paint circlePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    canvas.drawCircle(Offset(centerX, centerY), radius, circlePaint);

    Paint centerDotPaint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(centerX, centerY), 5, centerDotPaint);

    DateTime datetime = DateTime.now();

    double secondHandX =
        centerX + radius * 0.9 * cos((datetime.second * 6) * pi / 180 - pi / 2);
    double secondHandY =
        centerY + radius * 0.9 * sin((datetime.second * 6) * pi / 180 - pi / 2);
    Paint secondHandPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2;
    canvas.drawLine(Offset(centerX, centerY), Offset(secondHandX, secondHandY),
        secondHandPaint);

    double minuteHandX =
        centerX + radius * 0.7 * cos((datetime.minute * 6) * pi / 180 - pi / 2);
    double minuteHandY =
        centerY + radius * 0.7 * sin((datetime.minute * 6) * pi / 180 - pi / 2);
    Paint minuteHandPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4;
    canvas.drawLine(
      Offset(centerX, centerY),
      Offset(minuteHandX, minuteHandY),
      minuteHandPaint,
    );

    double hourHandX = centerX +
        radius *
            0.5 *
            cos(((datetime.hour % 12) * 30 + datetime.minute * 0.5) * pi / 180 -
                pi / 2);
    double hourHandY = centerY +
        radius *
            0.5 *
            sin(((datetime.hour % 12) * 30 + datetime.minute * 0.5) * pi / 180 -
                pi / 2);
    Paint hourHandPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 6;
    canvas.drawLine(
        Offset(centerX, centerY), Offset(hourHandX, hourHandY), hourHandPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CustomClock extends StatefulWidget {
  const CustomClock({super.key});

  @override
  CustomClockState createState() => CustomClockState();
}

class CustomClockState extends State<CustomClock> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(300, 300),
      painter: ClockPainter(),
    );
  }
}
