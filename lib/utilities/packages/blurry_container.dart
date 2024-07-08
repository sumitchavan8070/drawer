import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';

class BlurryContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final double elevation;
  final double blur;
  final EdgeInsetsGeometry padding;
  final Color color;
  final BorderRadius borderRadius;

  const BlurryContainer({
    Key? key,
    required this.child,
    this.height,
    this.width,
    this.blur = 5,
    this.elevation = 0,
    this.padding = const EdgeInsets.all(8),
    this.color = Colors.transparent,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
  }) : super(key: key);

  const BlurryContainer.square({
    Key? key,
    required this.child,
    double? dimension,
    this.blur = 5,
    this.elevation = 0,
    this.padding = const EdgeInsets.all(8),
    this.color = Colors.transparent,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
  })  : width = dimension,
        height = dimension,
        super(key: key);

  const BlurryContainer.expand({
    Key? key,
    required this.child,
    this.blur = 5,
    this.elevation = 0,
    this.padding = const EdgeInsets.all(8),
    this.color = Colors.transparent,
    this.borderRadius = BorderRadius.zero,
  })  : width = double.infinity,
        height = double.infinity,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      color: Colors.transparent,
      borderRadius: borderRadius,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            height: height,
            width: width,
            padding: padding,
            color: color,
            child: child,
          ),
        ),
      ),
    );
  }
}
