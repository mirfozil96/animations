import 'package:flutter/material.dart';

class PulsatingCircleAnimation extends StatelessWidget {
  const PulsatingCircleAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pulsating Circle Animation'),
      ),
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 10, end: 150),
          duration: const Duration(milliseconds: 1500),
          builder: (context, size, widget) {
            return Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.yellow,
                boxShadow: [
                  BoxShadow(
                    color: Colors.yellow.withOpacity(0.4),
                    blurRadius: size,
                    spreadRadius: size / 2.5,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
