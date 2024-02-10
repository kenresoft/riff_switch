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
  const RiffSwitchExample({super.key, title}) : _title = title;

  final String _title;

  @override
  State<RiffSwitchExample> createState() => _RiffSwitchExampleState();
}

class _RiffSwitchExampleState extends State<RiffSwitchExample> {
  late bool _switchValue_1 = false;
  late bool _switchValue_2 = false;
  late bool _switchValue_3 = false;
  late bool _switchValue_4 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      appBar: AppBar(title: Text(widget._title)),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(children: [
              const SizedBox(height: 30),

              // 1
              Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: Switch(
                      value: _switchValue_1,
                      onChanged: (value) => setState(() {}),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    height: 30,
                    child: Transform.rotate(
                      angle: 0,
                      child: RiffSwitch(
                        value: _switchValue_1,
                        onChanged: (value) => setState(() {
                          _switchValue_1 = value;
                        }),
                        type: RiffSwitchType.decorative,
                        enableSlide: false,
                        height: 10,

                        /// height must not be greater than width/2 (i.e. the max height)
                        //width: 800,
                        borderRadius: 20,
                        borderWidth: 3,
                      ),
                    ),
                  )
                  /*SizedBox(
                    width: 100,
                    height: 50,
                    child: Transform.rotate(
                      angle: 0,
                      child: RiffSwitch(
                        value: _switchValue_1,
                        onChanged: (value) => setState(() {
                          _switchValue_1 = value;
                        }),
                        type: RiffSwitchType.simple,
                        enableSlide: false,
                        height: 10,

                        /// height must not be greater than width/2 (i.e. the max height)
                        width: 800,
                        borderRadius: 2,
                      ),
                    ),
                  )*/,
                ],
              ),

              const SizedBox(height: 30),

              // 2
              SizedBox(
                width: 160,
                height: 30,
                child: RiffSwitch(
                  value: _switchValue_2,
                  onChanged: (value) => setState(() {
                    _switchValue_2 = value;
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
              ),

              const SizedBox(height: 30),

              // 2
              SizedBox(
                width: 160,
                height: 30,
                child: RiffSwitch(
                  value: _switchValue_2,
                  onChanged: (value) => setState(() {
                    _switchValue_2 = value;
                  }),
                  type: RiffSwitchType.decorative,
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
                  //height: 80,
                  //width: double.infinity,
                ),
              ),

              const SizedBox(height: 30),

              // 3
              SizedBox(
                //width: 160,
                //height: 100,
                child: RiffSwitch(
                  value: _switchValue_3,
                  onChanged: (value) => setState(() {
                    _switchValue_3 = value;
                  }),
                  type: RiffSwitchType.decorative,
                  activeColor: Colors.orange,
                  height: 166,
                  width: 1000,
                  borderWidth: 0,
                  borderRadius: 150,
                  thumbMargin: 10,
                ),
              ),

              const SizedBox(height: 30),

              // 4
              SizedBox(
                //width: 160,
                //height: 30,
                child: RiffSwitch(
                  value: _switchValue_4,
                  onChanged: (value) => setState(() {
                    _switchValue_4 = value;
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
                  height: 60,
                  width: 120,
                  borderWidth: 5,
                  borderRadius: 5,
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
