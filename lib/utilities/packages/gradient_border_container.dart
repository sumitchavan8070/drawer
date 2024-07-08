import 'package:flutter/material.dart';

class GradientBorderContainer extends StatelessWidget {
  final _GradientPainter _painter;
  final Widget _child;
  final Decoration? decoration;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  GradientBorderContainer({
    super.key,
    required double strokeWidth,
    required double radius,
    required LinearGradient gradient,
    required Widget child,
    this.decoration,
    this.padding,
    this.margin,
  })  : _painter = _GradientPainter(strokeWidth: strokeWidth, radius: radius, gradient: gradient),
        _child = child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        margin: margin,
        decoration: decoration,
        child: _child,
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradientPainter({required this.strokeWidth, required this.radius, required this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    Rect outerRect = Offset.zero & size;
    var outerRRect = RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect = Rect.fromLTWH(
      strokeWidth,
      strokeWidth,
      size.width - strokeWidth * 2,
      size.height - strokeWidth * 2,
    );
    var innerRRect = RRect.fromRectAndRadius(innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
