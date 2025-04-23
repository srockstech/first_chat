// import 'package:flutter/cupertino.dart';
//
// class CustomPageRoute extends PageRouteBuilder {
//   final Widget page;
//   final Widget currentPage;
//
//   CustomPageRoute({required this.page, required this.currentPage})
//       : super(pageBuilder: (context, animation, secondaryAnimation) => currentPage);
//
//   @override
//   Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
//     const begin = Offset(1.0, 0.0);
//     const end = Offset(0.0, 0.0);
//     const curve = Curves.easeOut;
//
//     var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//     var offsetAnimation = animation.drive(tween);
//
//     return Stack(
//       children: <Widget>[
//         SlideTransition(
//           position: Tween<Offset>(
//             begin: const Offset(0.0, 0.0),
//             end: const Offset(-1.0, 0.0),
//           ).animate(
//             CurvedAnimation(
//               parent: animation,
//               curve: curve,
//             ),
//           ),
//           child: currentPage,
//         ),
//         SlideTransition(
//           position: Tween<Offset>(
//             begin: const Offset(1.0, 0.0),
//             end: Offset.zero,
//           ).animate(
//             CurvedAnimation(
//               parent: animation,
//               curve: curve,
//             ),
//           ),
//           child: page,
//         )
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomPageRoute<T> extends PageRoute<T> {
  final RoutePageBuilder pageBuilder;
  final RoutePageBuilder currentPageBuilder;
  final PageTransitionsBuilder matchingBuilder = const CupertinoPageTransitionsBuilder(); // Default iOS/macOS (to get the swipe right to go back gesture)
  // final PageTransitionsBuilder matchingBuilder = const FadeUpwardsPageTransitionsBuilder(); // Default Android/Linux/Windows

  CustomPageRoute({required this.pageBuilder, required this.currentPageBuilder});

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {

    const curve = Curves.easeOut;

    return Stack(
      children: <Widget>[
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1.0, 0.0),
            end: const Offset(-1.0, 0.0),
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: curve,
            ),
          ),
          child: currentPageBuilder(context, animation, secondaryAnimation),

        ),
        SlideTransition(
          position: Tween<Offset>(
            begin: Offset.zero,
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: curve,
            ),
          ),
          child: pageBuilder(context, animation, secondaryAnimation),
        )
      ],
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 500); // Can give custom Duration, unlike in MaterialPageRoute

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return matchingBuilder.buildTransitions<T>(this, context, animation, secondaryAnimation, child);
    // return super.buildTransitions(context, animation, secondaryAnimation, child);
  }
}