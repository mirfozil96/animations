import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

/// An example showing how to drive two boolean state machine inputs.
class ExampleStateMachine extends StatefulWidget {
  const ExampleStateMachine({super.key});

  @override
  State<ExampleStateMachine> createState() => _ExampleStateMachineState();
}

class _ExampleStateMachineState extends State<ExampleStateMachine> {
  Artboard? _riveArtboard;
  SMIBool? _hoverInput;
  SMIBool? _pressInput;

  @override
  void initState() {
    super.initState();

    _loadRiveFile();
  }

  Future<void> _loadRiveFile() async {
    // Load the animation file from the bundle.
    final riveFile = await RiveFile.asset('assets/rocket.riv');

    // The artboard is the root of the animation and gets drawn in the
    // Rive widget.
    final artboard = riveFile.mainArtboard.instance();
    var controller = StateMachineController.fromArtboard(artboard, 'Button');
    if (controller != null) {
      artboard.addController(controller);
      _hoverInput = controller.getBoolInput('Hover');
      _pressInput = controller.getBoolInput('Press');
    }
    setState(() => _riveArtboard = artboard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Button State Machine')),
      body: _riveArtboard == null
          ? const SizedBox()
          : MouseRegion(
              onEnter: (_) => _hoverInput?.value = true,
              onExit: (_) => _hoverInput?.value = false,
              child: GestureDetector(
                onTapDown: (_) => _pressInput?.value = true,
                onTapCancel: () => _pressInput?.value = false,
                onTapUp: (_) => _pressInput?.value = false,
                child: Stack(
                  children: [
                    Rive(
                      fit: BoxFit.cover,
                      artboard: _riveArtboard!,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          'Try pressing the button...',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
