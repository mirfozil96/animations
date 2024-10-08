import 'package:flutter/material.dart';

class RadialProgressAnimation extends StatefulWidget {
  const RadialProgressAnimation({super.key});

  @override
  State<RadialProgressAnimation> createState() =>
      _RadialProgressAnimationState();
}

class _RadialProgressAnimationState extends State<RadialProgressAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  double progress = 0.0;
  Color color = Colors.blue;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    animation = Tween(begin: 0.0, end: progress).animate(controller);
  }

  void updateProgress(double newProgress) {
    setState(() {
      progress = newProgress;
      animation = Tween(begin: 0.0, end: progress).animate(controller);
      controller.reset();
      controller.forward();
    });
  }

  void updateColor(Color newColor) {
    setState(() {
      color = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: CircularProgressIndicator(
                        value: animation.value,
                        strokeWidth: 10,
                        backgroundColor: Colors.grey.shade100,
                        color: color,
                      ),
                    ),
                    Text(
                      '${(animation.value * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            Slider(
              value: progress,
              min: 0.0,
              max: 1.0,
              divisions: 100,
              label: '${(progress * 100).toInt()}%',
              onChanged: (value) {
                updateProgress(value);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                updateColor(Colors.red); // Example: Change color to red
              },
              child: const Text('Change Color to Red'),
            ),
          ],
        ),
      ),
    );
  }
}
