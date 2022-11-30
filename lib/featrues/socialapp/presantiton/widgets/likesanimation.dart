import 'package:flutter/cupertino.dart';

class LikesAnimations extends StatefulWidget {
  final Widget child;
  final bool isanimations;
  final Duration duration;
  final VoidCallback? onEnd;
  final bool smalllike;

  const LikesAnimations(
      {super.key,
      required this.child,
      required this.isanimations,
      this.duration = const Duration(milliseconds: 150),
      this.onEnd,
      this.smalllike = false});

  @override
  State<LikesAnimations> createState() => _LikesAnimationsState();
}

class _LikesAnimationsState extends State<LikesAnimations>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration:  Duration(milliseconds: widget.duration.inMilliseconds ~/2,));
    scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
  }

  @override
  void didUpdateWidget(covariant LikesAnimations oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isanimations != oldWidget.isanimations) {
      startanaimtions();
    }
  }

  startanaimtions() async {
    if (widget.isanimations || widget.smalllike) {
      await controller.forward();
      await controller.reverse();
      await Future.delayed(const Duration(milliseconds: 200));
      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
   dispose() {
    controller.dispose();
    super.dispose();
     
    
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
      );
  }
}
