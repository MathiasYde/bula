import 'package:flutter/material.dart';

class SizePageRouteTransition extends PageRouteBuilder {
  final Widget page;
  final Curve curve;

  SizePageRouteTransition({
    @required this.page,
    this.curve = Curves.linear,
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> primaryAnimation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> primaryAnimation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              Align(
            child: SizeTransition(
              sizeFactor: Tween<double>(
                begin: 0,
                end: 1,
              ).animate(
                CurvedAnimation(
                  parent: primaryAnimation,
                  curve: Curves.fastLinearToSlowEaseIn,
                ),
              ),
              child: child,
            ),
          ),
        );
}

class SlidePageRouteTransition extends PageRouteBuilder {
  final Widget page;
  final AxisDirection direction;
  final Curve curve;

  SlidePageRouteTransition({
    @required this.page,
    this.direction = AxisDirection.left,
    this.curve = Curves.linear,
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> primaryAnimation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> primaryAnimation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: Offset(
                (direction == AxisDirection.left)
                    ? 1
                    : (direction == AxisDirection.right) ? -1 : 0,
                (direction == AxisDirection.down)
                    ? 1
                    : (direction == AxisDirection.up) ? -1 : 0,
              ),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: primaryAnimation,
                curve: curve,
              ),
            ),
            child: child,
          ),
        );
}
