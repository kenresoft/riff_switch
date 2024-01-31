import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riff_switch/riff_switch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const RiffSwitchExample(title: 'RiffSwitch Example Page'),
    );
  }
}

class RiffSwitchExample extends StatefulWidget {
  const RiffSwitchExample({Key? key, title})
      : _title = title,
        super(key: key);

  final String _title;

  @override
  State<RiffSwitchExample> createState() => _RiffSwitchExampleState();
}

class _RiffSwitchExampleState extends State<RiffSwitchExample> {
  late bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      appBar: AppBar(title: Text(widget._title)),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(children: [
          const SizedBox(height: 30),

          // 1
          RiffSwitch(
            value: _switchValue,
            onChanged: (value) => setState(() {
              _switchValue = value;
            }),
            type: RiffSwitchType.simple,
            enableSlide: false,
          ),

          const SizedBox(height: 30),

          // 2
          RiffSwitch(
            value: _switchValue,
            onChanged: (value) => setState(() {
              _switchValue = value;
            }),
            type: RiffSwitchType.simple,
            activeText: const Text("Accept"),
            inactiveText: const Text("Decline"),
            thumbColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.greenAccent;
              }
              return Colors.pinkAccent;
            }),
            trackColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.grey;
              }
              return Colors.grey;
            }),
          ),

          const SizedBox(height: 30),

          // 3
          RiffSwitch(
            value: _switchValue,
            onChanged: (value) => setState(() {
              _switchValue = value;
            }),
            type: RiffSwitchType.decorative,
            activeColor: Colors.orange,
          ),

          const SizedBox(height: 30),

          // 4
          RiffSwitch(
            value: _switchValue,
            onChanged: (value) => setState(() {
              _switchValue = value;
            }),
            type: RiffSwitchType.decorative,
            activeChild: const Card(
              color: CupertinoColors.systemBlue,
              child: FlutterLogo(),
            ),
            inactiveChild: const Card(
              color: CupertinoColors.systemYellow,
              child: FlutterLogo(),
            ),
          )
        ]),
      ),
    );
  }
}
