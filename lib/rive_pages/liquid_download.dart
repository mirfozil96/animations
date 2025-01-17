import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

/// An example showing how to drive a StateMachine via a trigger and number
/// input.
class LiquidDownload extends StatefulWidget {
  const LiquidDownload({super.key});

  @override
  State<LiquidDownload> createState() => _LiquidDownloadState();
}

class _LiquidDownloadState extends State<LiquidDownload> {
  Artboard? _riveArtboard;
  SMITrigger? _start;
  SMINumber? _progress;

  @override
  void initState() {
    super.initState();
    _loadRiveFile();
  }

  Future<void> _loadRiveFile() async {
    final file = await RiveFile.asset('assets/liquid_download.riv');
    // The artboard is the root of the animation and gets drawn in the
    // Rive widget.
    final artboard = file.mainArtboard.instance();
    var controller = StateMachineController.fromArtboard(artboard, 'Download');
    if (controller != null) {
      artboard.addController(controller);
      _start = controller.getTriggerInput('Download');
      _progress = controller.getNumberInput('Progress');
    }
    setState(() => _riveArtboard = artboard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liquid Download'),
      ),
      body: Center(
        child: _riveArtboard == null
            ? const SizedBox()
            : GestureDetector(
                onTapDown: (_) => _start?.value = true,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'Press to activate, slide for progress...',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Slider(
                      value: _progress!.value,
                      min: 0,
                      max: 100,
                      label: _progress!.value.round().toString(),
                      onChanged: (double value) => setState(() {
                        _progress!.value = value;
                      }),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Rive(
                        artboard: _riveArtboard!,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
