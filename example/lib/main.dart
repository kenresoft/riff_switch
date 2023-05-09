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
        primarySwatch: Colors.blue,
      ),
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
      appBar: AppBar(title: Text(widget._title)),
      body: Column(
        children: [
          RiffSwitch(
            value: _switchValue,
            onChanged: (value) => setState(() {
              _switchValue = value;
            }),
            type: RiffSwitchType.simple,
          ),
          const SizedBox(height: 30),
          RiffSwitch(
            value: _switchValue,
            onChanged: (value) => setState(() {
              _switchValue = value;
            }),
            type: RiffSwitchType.simple,
            activeText: const Text("Decline"),
            inactiveText: const Text("Accept"),
          ),
          const SizedBox(height: 30),
          RiffSwitch(
            value: _switchValue,
            onChanged: (value) => setState(() {
              _switchValue = value;
            }),
            type: RiffSwitchType.decorative,
          ),
          const SizedBox(height: 30),
          RiffSwitch(
            value: _switchValue,
            onChanged: (value) => setState(() {
              _switchValue = value;
            }),
            type: RiffSwitchType.decorative,
            activeChild: const Card(
              color: CupertinoColors.systemBlue,
            ),
            inactiveChild: const Card(color: CupertinoColors.systemYellow),
          )
        ],
      ),
    );
  }
}
