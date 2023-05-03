import 'package:animate_demo/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final duration = 1000.ms;
    final scale = ScaleEffect(
      duration: duration,
      begin: Offset(appState.minScale, appState.minScale),
      end: const Offset(2.0, 2.0),
    );
    final fade = FadeEffect(duration: duration);
    final eff1 = <Effect>[fade, scale];
    final eff2 = <Effect>[scale, fade];
    //
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Demo'),
      ),
      body: ListView(children: [
        ListTile(
          leading: const SizedBox(),
          isThreeLine: true,
          subtitle: const Text(
              'Use the slider to see the affect of 0 and non-zero ScaleEffect begin value.\nNote how the ScaleEffect fails when: begin > 0 and it follows the FadeEffect'),
          title: IconButton(
            iconSize: 50,
            onPressed: appState.isAnimating ? null : () => appState.begin(),
            icon: Icon(appState.isAnimating ? Icons.block : Icons.play_arrow),
          ),
          trailing: SizedBox(
            width: 100,
            child: Slider.adaptive(
              value: appState.minScale,
              onChanged: (d) => appState.setMinScale(d),
              min: appState.minMinScale,
              max: appState.maxMinScale,
              divisions: 1,
              label: 'Min. scale: ${appState.minScale}',
            ),
          ),
        ),
        const Divider(),
        MyTile(
            effects: eff1,
            description:
                'Effects 1: fade, scale (begin = ${appState.minScale})'),
        const Divider(),
        MyTile(
            effects: eff2,
            description:
                'Effects 2: scale (begin = ${appState.minScale}), fade'),
        const Divider(),
      ]),
    );
  }
}

class MyTile extends StatelessWidget {
  const MyTile({
    required this.effects,
    required this.description,
    super.key,
  });

  final List<Effect> effects;
  final String description;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return ListTile(
      title: Center(
        child: Animate(
          target: appState.goForward ? 1 : 0,
          onPlay: (_) => appState.animating(true),
          onComplete: (_) => appState.animating(false),
          effects: effects,
          child: Text(description),
        ),
      ),
    );
  }
}
