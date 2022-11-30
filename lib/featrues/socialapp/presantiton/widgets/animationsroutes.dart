import 'package:flutter/cupertino.dart';

class SlideRight extends PageRouteBuilder {
  final Widget page;
  SlideRight({required this.page})
      : super(
            pageBuilder: (
              context,
              anaimation,
              animation2,
            ) =>
                page,
            transitionsBuilder: (context, anaimation, animation2, child) {
              var begin = const Offset(-1, 0);
              var end = const Offset(0, 0);
              var tween = Tween(begin: begin, end: end);
              //var offsetanimation = anaimation.drive(tween);
              var carve = CurvedAnimation(
                  parent: anaimation, curve: Curves.linearToEaseOut);

              return SlideTransition(
                position: tween.animate(carve),
                child: child,
              );
            });
}

class ScaleRoute extends PageRouteBuilder {
  final Widget page;
  ScaleRoute({required this.page})
      : super(
            pageBuilder: (
              context,
              anaimation,
              animation2,
            ) =>
                page,
            transitionsBuilder: (context, anaimation, animation2, child) {
              var begin = 0.0;
              var end = 1.0;
              var tween = Tween(begin: begin, end: end);
              //var offsetanimation = anaimation.drive(tween);
              var carve =
                  CurvedAnimation(parent: anaimation, curve: Curves.decelerate);

              return ScaleTransition(
                scale: tween.animate(carve),
                child: child,
              );
            });
}

class RotaionsRoute extends PageRouteBuilder {
  final Widget page;
  RotaionsRoute({required this.page})
      : super(
            pageBuilder: (context, animation, animation2) => page,
            transitionsBuilder: (context, animation, animation2, child) {
              var begin = 0.0;
              var end = 1.0;
              var tween = Tween(begin: begin, end: end);
              var carve = CurvedAnimation(
                  parent: animation, curve: Curves.fastOutSlowIn);

              return RotationTransition(
                turns: tween.animate(carve),
                child: child,
              );
            });
}

class AlignAnimationsRoute extends PageRouteBuilder {
  final Widget page;
  AlignAnimationsRoute({required this.page})
      : super(
            pageBuilder: (context, aniation, animation1) => page,
            transitionsBuilder: (context, aniation, animation1, child) {
              return Align(
                alignment: Alignment.topCenter,
                child: SizeTransition(
                  sizeFactor: aniation,
                  child: child,
                ),
              );
            });
}

class DoubleAnimaitonsRoute extends PageRouteBuilder {
  final Widget page;
  DoubleAnimaitonsRoute({required this.page})
      : super(
            pageBuilder: (context, anaimation, animaiton1) => page,
            transitionsBuilder: (context, anaimation, animaiton1, child) {
              var begin = const Offset(0.0, 1.0);
              var end = const Offset(0.0, 0.0);
              var tween = Tween(begin: begin, end: end);
              var curaveanimations = CurvedAnimation(
                  parent: anaimation, curve: Curves.linearToEaseOut);
              return SlideTransition(
                position: tween.animate(curaveanimations),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizeTransition(
                    sizeFactor: anaimation,
                    child: child,
                  ),
                ),
              );
            });
}

class DoubleAnimaitonsRoute2 extends PageRouteBuilder {
  final Widget page;
  DoubleAnimaitonsRoute2({required this.page})
      : super(
            pageBuilder: (context, anaimation, animaiton1) => page,
            transitionsBuilder: (context, anaimation, animaiton1, child) {
              var begin = const Offset(1.0, 0.0);
              var end = const Offset(0.0, 0.0);
              var tween = Tween(begin: begin, end: end);
              var curaveanimations = CurvedAnimation(
                  parent: anaimation, curve: Curves.linearToEaseOut);
              return SlideTransition(
                position: tween.animate(curaveanimations),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizeTransition(
                    sizeFactor: anaimation,
                    child: child,
                  ),
                ),
              );
            });
}

class SlideLeft extends PageRouteBuilder {
  final Widget page;
  SlideLeft({required this.page})
      : super(
            pageBuilder: (
              context,
              anaimation,
              animation2,
            ) =>
                page,
            transitionsBuilder: (context, anaimation, animation2, child) {
              var begin = const Offset(-1, 0);
              var end = const Offset(0, 0);
              var tween = Tween(begin: begin, end: end);
              //var offsetanimation = anaimation.drive(tween);
              var carve = CurvedAnimation(
                  parent: anaimation, curve: Curves.linearToEaseOut);

              return SlideTransition(
                position: tween.animate(carve),
                child: child,
              );
            });
}
