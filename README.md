## RiffSwitch

This is a package for a custom Flutter Switch widget called RiffSwitch.

## Features

Customized Switch

## Getting started

Add to your [pubspec.yaml](pubspec.yaml) file the dependency:

```yaml

dependencies:
  flutter:
    sdk: flutter

  riff_switch:
    git: 
      url: git@github.com:kenresoft/riff_switch.git
      ref: release

```

## Usage

```dart
// 1
  RiffSwitch(
    value: _switchValue,
    onChanged: (value) => setState(() {
      _switchValue = value;
    }),
    type: RiffSwitchType.simple,
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
```


## Screenshot

<img alt="Screenshot 1" height="500" src="screenshots\Screenshot_1.png" title="Screenshot 1" width="200"/>

<img alt="Screenshot 1" height="500" src="screenshots\Screen_recording_1.gif" title="Screenshot 1" width="200"/>


## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
