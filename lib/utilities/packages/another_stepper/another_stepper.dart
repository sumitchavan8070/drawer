import 'package:flutter/material.dart';
import 'package:ielts/utilities/theme/app_box_decoration.dart';
import 'package:ielts/utilities/theme/app_colors.dart';

class AnotherStepper extends StatelessWidget {
  const AnotherStepper({
    Key? key,
    required this.stepperList,
    this.activeIndex = 0,
    this.activeBarColor = AppColors.darkMintGreen,
    this.inActiveBarColor = AppColors.primaryColor,
  }) : super(key: key);

  final List<StepperData> stepperList;
  final int activeIndex;
  final Color activeBarColor;
  final Color inActiveBarColor;

  @override
  Widget build(BuildContext context) {
    var crossAxisAlign = CrossAxisAlignment.start;

    final Iterable<int> iterable = Iterable<int>.generate(stepperList.length);
    return Flex(
      crossAxisAlignment: crossAxisAlign,
      direction: Axis.vertical,
      children: iterable.map((index) => _getPreferredStepper(context, index: index)).toList(),
    );
  }

  Widget _getPreferredStepper(BuildContext context, {required int index}) {
    return VerticalStepperItem(
      index: index,
      item: stepperList[index],
      totalLength: stepperList.length,
      activeIndex: activeIndex,
      inActiveBarColor: inActiveBarColor,
      activeBarColor: activeBarColor,
    );
  }
}

class StepperData {
  final StepperText? subtitle;
  final Widget? iconWidget;

  StepperData({this.iconWidget, this.subtitle});
}

class StepperText {
  final String text;
  final TextStyle? textStyle;

  StepperText(this.text, {this.textStyle});
}

class VerticalStepperItem extends StatefulWidget {
  const VerticalStepperItem({
    Key? key,
    required this.item,
    required this.index,
    required this.totalLength,
    required this.activeIndex,
    required this.activeBarColor,
    required this.inActiveBarColor,
  }) : super(key: key);

  final StepperData item;
  final int index;
  final int totalLength;
  final int activeIndex;
  final Color activeBarColor;
  final Color inActiveBarColor;

  @override
  State<VerticalStepperItem> createState() => _VerticalStepperItemState();
}

class _VerticalStepperItemState extends State<VerticalStepperItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double containerWidth = 0;
  double containerHeight = 0;

  String buttonText = 'Let\'s get started';

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {}
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: getChildren(),
    );
  }

  List<Widget> getChildren() {
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: StepperDot(
                    index: widget.index,
                    totalLength: widget.totalLength,
                    activeIndex: widget.activeIndex,
                  ),
                ),
              ),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  if (widget.activeIndex == widget.index) {
                    _animationController.forward();
                  }
                  return AnimatedBuilder(
                    animation: _animationController,
                    builder: (BuildContext context, Widget? child) {
                      const double textWidth = 40;
                      final double width = _animation.value * textWidth;
                      return Container(
                        width: 3,
                        height: widget.index == widget.totalLength - 1 ? 0 : 40,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            8.0,
                          ),
                        ),
                        child: Stack(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(seconds: 3),
                              width: 3,
                              height: width >= textWidth ? textWidth : width,
                              decoration: const BoxDecoration(
                                color: AppColors.darkMintGreen,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (widget.index <= widget.activeIndex
                        ? "Done"
                        : widget.index == widget.activeIndex + 1
                            ? "In Progress"
                            : "Pending")
                    .toUpperCase(),
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 15,
                      color: widget.index <= widget.activeIndex
                          ? AppColors.darkMintGreen
                          : AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              if (widget.item.subtitle != null) ...[
                Text(
                  widget.item.subtitle!.text,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 15,
                        color: AppColors.darkGrey,
                      ),
                ),
              ],
            ],
          ),
        ],
      ),
    ];
  }
}

class StepperDot extends StatelessWidget {
  const StepperDot({
    Key? key,
    required this.index,
    required this.totalLength,
    required this.activeIndex,
  }) : super(key: key);

  final int index;
  final int totalLength;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    final bool isNextActive = index == activeIndex + 1;

    return index <= activeIndex
        ? Container(
            decoration: AppBoxDecoration.getBoxDecoration(
              color: AppColors.darkMintGreen,
              borderRadius: 30,
            ),
            padding: const EdgeInsets.all(2),
            child: const Icon(
              Icons.check,
              size: 14,
              color: AppColors.white,
            ),
          )
        : isNextActive == true
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : Container(
                height: 20,
                width: 20,
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.5),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              );
  }
}
