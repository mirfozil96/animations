import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SpeedyAnimation extends StatefulWidget {
  const SpeedyAnimation({super.key});

  @override
  State<SpeedyAnimation> createState() => _SpeedyAnimationState();
}

class _SpeedyAnimationState extends State<SpeedyAnimation> {
  SMITrigger? _bump;
  late RiveAnimationController _oneShotController;
  late SpeedController _speedController;
  bool _isPlaying = false;
  double _speedMultiplier = 1.0;

  void _onRiveInit(Artboard artboard) {
    final stateMachineController =
        StateMachineController.fromArtboard(artboard, 'bumpy');
    if (stateMachineController != null) {
      artboard.addController(stateMachineController);
      _bump = stateMachineController.getTriggerInput('bump');
    }
    artboard.addController(_oneShotController);
    artboard.addController(_speedController);
  }

  void _hitBump() => _bump?.fire();

  @override
  void initState() {
    super.initState();
    _oneShotController = OneShotAnimation(
      'bounce',
      autoplay: false,
      onStop: () => setState(() => _isPlaying = false),
      onStart: () => setState(() => _isPlaying = true),
    );
    _speedController =
        SpeedController('curves', speedMultiplier: _speedMultiplier);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speedy Animation'),
      ),
      body: Stack(
        children: [
          Center(
            child: GestureDetector(
              onTap: _hitBump,
              child: RiveAnimation.asset(
                'assets/vehicles.riv',
                fit: BoxFit.cover,
                onInit: _onRiveInit,
                animations: const ['idle', 'curves'],
              ),
            ),
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Bump the van or play animations!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Adjust Speed Multiplier'),
                  Slider(
                    value: _speedMultiplier,
                    min: 0.5,
                    max: 10.0,
                    divisions: 20,
                    label: _speedMultiplier.toStringAsFixed(1),
                    onChanged: (value) {
                      setState(() {
                        _speedMultiplier = value;
                        _speedController.speedMultiplier = _speedMultiplier;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: FloatingActionButton(
          onPressed: () =>
              _isPlaying ? null : _oneShotController.isActive = true,
          tooltip: 'Bounce',
          child: const Icon(Icons.arrow_upward),
        ),
      ),
    );
  }
}

class SpeedController extends SimpleAnimation {
  double speedMultiplier;

  SpeedController(
    super.animationName, {
    super.mix,
    this.speedMultiplier = 1,
  });

  @override
  void apply(RuntimeArtboard artboard, double elapsedSeconds) {
    if (instance == null || !instance!.keepGoing) {
      isActive = false;
    }
    instance!
      ..animation.apply(instance!.time, coreContext: artboard, mix: mix)
      ..advance(elapsedSeconds * speedMultiplier);
  }
}
