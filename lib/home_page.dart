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
    final rotate = RotateEffect(duration: duration);
    final scale = ScaleEffect(
      duration: duration,
      begin: Offset.zero,
      end: const Offset(2, 2),
    );
    final fade = FadeEffect(duration: duration);
    // these 3 effects-lists differ only in the position of "fade"
    // it seems that, after the first "play" to target of 1,
    // the updates to the target value no longer propagate past the "fade"
    // which I assume is a bug?
    final working1 = <Effect>[rotate, scale, fade];
    final working2 = <Effect>[scale, fade, rotate];
    final broken1 = <Effect>[fade, rotate, scale];
    //
    final broken2 = <Effect>[rotate, fade, scale];
    final broken3 = <Effect>[fade, scale, rotate];
    final working3 = <Effect>[scale, rotate, fade];
    //
    const working1Text = 'All working (rotate, scale, fade)';
    const working2Text = 'All working (scale, fade, rotate)';
    const broken1Text = 'Broken: (fade: yes, rotate: no, scale: no) - after 2nd update';
    //
    const broken2Text = 'Broken: (rotate: yes, fade: yes, scale: no) - after 2nd update';
    const broken3Text = 'Broken: (fade: yes, scale: no, rotate: no) - after 2nd update';
    const working3Text = 'All working (scale, rotate, fade)';
    //
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Demo'),
      ),
      body: ListView(children: [
        ListTile(
          leading: Text('Updates: ${appState.clicks}'),
          title: IconButton(
            iconSize: 50,
            onPressed: appState.animating ? null : () => appState.toggle(),
            icon: Icon(appState.animating ? Icons.block : Icons.play_arrow),
          ),
        ),
        const Divider(),
        MyTile(effects: working1, description: working1Text),
        const Divider(),
        MyTile(effects: working2, description: working2Text),
        const Divider(),
        MyTile(effects: broken1, description: broken1Text),
        const Divider(),
        MyTile(effects: broken2, description: broken2Text),
        const Divider(),
        MyTile(effects: broken3, description: broken3Text),
        const Divider(),
        MyTile(effects: working3, description: working3Text),
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
          target: appState.start ? 1 : 0,
          onPlay: (c) => appState.update(true),
          onComplete: (c) => appState.update(false),
          effects: effects,
          child: Text(description),
        ),
      ),
    );
  }
}
