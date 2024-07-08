import 'package:flutter/material.dart';
import 'package:ielts/utilities/packages/blurry_container.dart';

enum BlurEffectStyle { auto, light, dark }

class BlurNavbar extends StatefulWidget {
  const BlurNavbar({
    Key? key,
    required this.onTap,
    this.style = BlurEffectStyle.auto,
    this.selectedColor,
    this.borderRadius = 24,
    required this.items,
    this.currentIndex = 0,
    this.fontSize = 10,
    this.iconSize = 40,
  })  : assert(items.length > 1 && items.length <= 5, '至少2个，至多5个'),
        assert(currentIndex >= 0 && currentIndex < items.length),
        super(key: key);

  final BlurEffectStyle style;
  final Color? selectedColor;
  final double borderRadius;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BlurNavbarItem> items;
  final double fontSize;
  final double iconSize;

  @override
  State<BlurNavbar> createState() => _BlurNavbarState();
}

class _BlurNavbarState extends State<BlurNavbar> with SingleTickerProviderStateMixin {
  BlurEffectStyle get style => widget.style;

  double get borderRadius => widget.borderRadius;

  List<BlurNavbarItem> get items => widget.items;

  int get selectedIndex => widget.currentIndex;

  double get iconSize => widget.iconSize;

  double get fontSize => widget.fontSize;

  Color? get selectedColor => widget.selectedColor;

  late final AnimationController _animation =
      AnimationController(duration: const Duration(milliseconds: 350), vsync: this);

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const borderWidth = .7;
    final itemWidth = (MediaQuery.of(context).size.width - borderWidth * 2) / items.length;
    final radius = Radius.circular(borderRadius);

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6, left: 12, right: 12),
          child: BlurryContainer(
            blur: 26,
            borderRadius: BorderRadius.all(radius),
            child: SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 6, left: 16, right: 16),
          height: kBottomNavigationBarHeight,
          clipBehavior: Clip.none,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(radius),
            border: Border.all(
              color: Colors.grey.withOpacity(0.35),
              width: borderWidth,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          child: ClipRRect(
            clipBehavior: Clip.none,
            borderRadius: BorderRadius.only(topLeft: radius, topRight: radius),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items
                  .asMap()
                  .map(
                    (idx, item) => MapEntry(
                      idx,
                      _itemBuilder(context, idx, item, itemWidth),
                    ),
                  )
                  .values
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  _onTap(int index) {
    if (selectedIndex == index || _animation.isAnimating) {
      return;
    }
    // _onItemTapped(index);
    widget.onTap(index);
    _animation.forward(from: 0.0);
  }

  // void _onItemTapped(int index) {
  //   switch (index) {
  //     case 0:
  //       MyNavigator.pushNamed(GoPaths.ieltsDashboard);
  //       break;
  //     case 1:
  //       MyNavigator.pushNamed(GoPaths.buyPlan);
  //       break;
  //     case 2:
  //       MyNavigator.pushNamed(GoPaths.profile);
  //       break;
  //     default:
  //       MyNavigator.pushNamed(GoPaths.login);
  //   }
  // }

  Widget _itemBuilder(BuildContext context, int index, BlurNavbarItem item, double width) {
    return GestureDetector(
      onTap: () => _onTap(index),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.bottomCenter,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            item.icon!,
          ],
        ),
      ),
    );
  }
}

class BlurNavbarItem {
  final Widget? icon;

  BlurNavbarItem({
    this.icon,
  }) : assert(icon != null);
}
