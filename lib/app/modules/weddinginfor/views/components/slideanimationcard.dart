import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SlideAnimationCard extends StatefulWidget {
  const SlideAnimationCard(
      {super.key,
      required this.animationKey,
      required this.child,
      required this.height,
      required this.width,
      required this.offset});

  final Key animationKey;
  final Widget child;
  final double height;
  final double width;
  final Offset offset;

  @override
  State<SlideAnimationCard> createState() => _SlideAnimationCardState(
      key: this.animationKey,
      child: this.child,
      height: this.height,
      width: this.width,
      offset: this.offset);
}

class _SlideAnimationCardState extends State<SlideAnimationCard>
    with SingleTickerProviderStateMixin {
  _SlideAnimationCardState(
      {required this.key,
      required this.child,
      required this.height,
      required this.width,
      required this.offset});

  bool isShow = false;
  final Key key;
  final Widget child;
  final double height;
  final double width;
  final Offset offset;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..forward();
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: this.offset,
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: key,
      onVisibilityChanged: (VisibilityInfo info) {
        final height = info.visibleBounds.height;
        final currentIsShow = height > 0;
        // print(info.visibleBounds.height);
        if (!_controller.isAnimating && !this.isShow && currentIsShow) {
          _controller.reset();
          _controller.forward();
        }

        this.setState(() {
          this.isShow = currentIsShow;
        });
      },
      child: SizedBox(
        height: this.height,
        width: this.width,
        child: isShow
            ? SlideTransition(
                position: _offsetAnimation,
                child: this.child,
              )
            : Container(),
      ),
    );
  }
}
