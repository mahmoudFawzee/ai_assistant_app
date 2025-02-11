import 'package:flutter/material.dart';

class TransitionAnimation extends StatefulWidget {
  const TransitionAnimation({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  _AnimatedWidgetExampleState createState() => _AnimatedWidgetExampleState();
}

class _AnimatedWidgetExampleState extends State<TransitionAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Define the animation
    _animation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Start from the right edge
      end: const Offset(0.0, 0.0), // Move to the center
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Restart the animation when the user taps
        _controller.reset();
        _controller.forward();
      },
      child: SlideTransition(
        position: _animation,
        child: widget.child,
      ),
    );
  }
}
