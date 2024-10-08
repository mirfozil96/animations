import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'simple_animations/custom_painter_example/bouncing_ball_animation.dart';
import 'simple_animations/explicit_examples/list_animation.dart';
import 'simple_animations/explicit_examples/loading_animation.dart';
import 'simple_animations/implicit_examples/animated_color_pallete.dart';
import 'simple_animations/implicit_examples/animated_shopping_cart_button.dart';
import 'simple_animations/implicit_examples/animated_tween_animation_builder_example.dart';
import 'simple_animations/page_route_builder_animation/splash_animation.dart';
import 'rive_pages/login_screen.dart';
import 'rive_pages/artboard_nested_inputs.dart';
import 'rive_pages/custom_asset_loading.dart';
import 'rive_pages/custom_cached_asset_loading.dart';
import 'rive_pages/carousel.dart';
import 'rive_pages/custom_controller.dart';
import 'rive_pages/event_open_url_button.dart';
import 'rive_pages/event_star_rating.dart';
import 'rive_pages/example_state_machine.dart';
import 'rive_pages/liquid_download.dart';
import 'rive_pages/little_machine.dart';
import 'rive_pages/play_one_shot_animation.dart';
import 'rive_pages/play_pause_animation.dart';
import 'rive_pages/rive_audio.dart';
import 'rive_pages/rive_audio_out_of_band.dart';
import 'rive_pages/simple_animation.dart';
import 'rive_pages/simple_animation_network.dart';
import 'rive_pages/simple_machine_listener.dart';
import 'rive_pages/simple_state_machine.dart';
import 'rive_pages/skinning_demo.dart';
import 'rive_pages/state_machine_skills.dart';
import 'rive_pages/basic_text.dart';

void main() {
  unawaited(RiveFile.initialize());
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: _backgroundColor,
        appBarTheme: const AppBarTheme(backgroundColor: _appBarColor),
        colorScheme: ColorScheme.fromSwatch().copyWith(primary: _primaryColor),
      ),
      themeMode: ThemeMode.dark,
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      _Category('Bestanimations', BestAnimationPage()),
      _Category('Animations', AnimationPage()),
      _Category('State Machines', StateMachinePage()),
      _Category('Controllers', ControllerPage()),
      _Category('Events', EventPage()),
      _Category('Miscellaneous', MiscPage()),
      _Category('Whitout rivo', WoithoutRivoPage()),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Rive Example Categories')),
      body: Center(
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return Column(
              children: [
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    child: SizedBox(
                      width: 260,
                      height: 70,
                      child: Center(
                        child: Text(
                          category.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => category.page,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }
}

class WoithoutRivoPage extends StatelessWidget {
  WoithoutRivoPage({super.key});

  final _pages = [
    const _Page('BouncingBallAnimation', BouncingBallAnimation()),
    const _Page('ListAnimation', ListAnimation()),
    const _Page('RadialProgressAnimation', RadialProgressAnimation()),
    const _Page('AnimatedColorPalette', AnimatedColorPalette()),
    const _Page('ShoppingCartButton', ShoppingCartButton()),
    const _Page('PulsatingCircleAnimation', PulsatingCircleAnimation()),
    const _Page('SplashAnimation', SplashAnimation()),
  ];
  @override
  Widget build(BuildContext context) {
    return _buildPageList(context, _pages);
  }
}

class BestAnimationPage extends StatelessWidget {
  BestAnimationPage({super.key});

  final _pages = [
    const _Page('Login Screen', LoginScreen()),
    const _Page('Skills Machine', StateMachineSkills()),
    const _Page('Custom Controller - Speed', SpeedyAnimation()),
    const _Page('Liquid Download', LiquidDownload()),
    const _Page('Cached Asset Loading', CustomCachedAssetLoading()),
    const _Page('Skinning Demo', SkinningDemo()),
    const _Page('Event Star Rating', EventStarRating()),
  ];
  @override
  Widget build(BuildContext context) {
    return _buildPageList(context, _pages);
  }
}

class AnimationPage extends StatelessWidget {
  AnimationPage({super.key});

  final _pages = [
    const _Page('Simple Animation - Asset', SimpleAssetAnimation()),
    const _Page('Simple Animation - Network', SimpleNetworkAnimation()),
    const _Page('Play/Pause Animation', PlayPauseAnimation()),
    const _Page('Play One-Shot Animation', PlayOneShotAnimation()),
    const _Page('Animation Carousel', AnimationCarousel()),
  ];

  @override
  Widget build(BuildContext context) {
    return _buildPageList(context, _pages);
  }
}

class StateMachinePage extends StatelessWidget {
  StateMachinePage({super.key});

  final _pages = [
    const _Page('Button State Machine', ExampleStateMachine()),
    const _Page('Simple State Machine', SimpleStateMachine()),
    const _Page('State Machine with Listener', StateMachineListener()),
  ];

  @override
  Widget build(BuildContext context) {
    return _buildPageList(context, _pages);
  }
}

class ControllerPage extends StatelessWidget {
  final _pages = [
    const _Page('Nested Inputs', ArtboardNestedInputs()),
  ];

  ControllerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPageList(context, _pages);
  }
}

class EventPage extends StatelessWidget {
  EventPage({super.key});

  final _pages = [
    const _Page('Event Open URL Button', EventOpenUrlButton()),
  ];

  @override
  Widget build(BuildContext context) {
    return _buildPageList(context, _pages);
  }
}

class MiscPage extends StatelessWidget {
  MiscPage({super.key});

  final _pages = [
    const _Page('Little Machine', LittleMachine()),
    const _Page('Basic Text', BasicText()),
    const _Page('Asset Loading', CustomAssetLoading()),
    const _Page('Rive Audio', RiveAudioExample()),
    const _Page('Rive Audio [Out-of-Band]', RiveAudioOutOfBandExample()),
  ];

  @override
  Widget build(BuildContext context) {
    return _buildPageList(context, _pages);
  }
}

Widget _buildPageList(BuildContext context, List<_Page> pages) {
  return Scaffold(
    appBar: AppBar(title: const Text('Rive Pages')),
    body: Center(
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final page = pages[index];
          return Column(
            children: [
              const SizedBox(height: 30),
              SizedBox(height: 70, child: _NavButton(page: page)),
              const SizedBox(height: 10),
            ],
          );
        },
        itemCount: pages.length,
      ),
    ),
  );
}

/// Class used to organize demo pages.
class _Page {
  final String name;
  final Widget page;

  const _Page(this.name, this.page);
}

/// Category class for navigation.
class _Category {
  final String name;
  final Widget page;

  const _Category(this.name, this.page);
}

/// Button to navigate to demo pages.
class _NavButton extends StatelessWidget {
  const _NavButton({required this.page});

  final _Page page;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: SizedBox(
          width: 250,
          child: Center(
            child: Text(
              page.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => page.page,
            ),
          );
        },
      ),
    );
  }
}

const _appBarColor = Color(0xFF323232);
const _backgroundColor = Color(0xFF1D1D1D);
const _primaryColor = Color(0xFF57A5E0);
