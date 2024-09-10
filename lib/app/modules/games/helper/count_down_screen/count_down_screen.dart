import 'package:alert_brains/global_presentation/build_text.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountdownScreen extends StatefulWidget {
  final int duration;
  final String resonOfWaiting;
  final VoidCallback onCountdownFinish;

  const CountdownScreen({
    Key? key,
    required this.duration,
    required this.resonOfWaiting,
    required this.onCountdownFinish,
  }) : super(key: key);

  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Timer _timer;
  late int _countdown;

  @override
  void initState() {
    super.initState();
    _countdown = widget.duration;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );
    _controller.repeat(reverse: true);

    // Start the countdown timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          // Once countdown is complete, execute the callback function
          widget.onCountdownFinish();
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the animation controller
    _timer.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BuildText(
                text: widget.resonOfWaiting,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              ScaleTransition(
                scale: _animation,
                child: Text(
                  '$_countdown',
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
