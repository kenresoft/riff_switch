# RiffSwitch

[![pub package](https://img.shields.io/pub/v/riff_switch.svg?label=riff_switch&color=blue)](https://pub.dev/packages/riff_switch)
[![pub points](https://img.shields.io/pub/points/riff_switch?logo=dart)](https://pub.dev/packages/riff_switch/score)
[![popularity](https://img.shields.io/pub/popularity/riff_switch?logo=dart&color=yellow)](https://pub.dev/packages/riff_switch/score)
[![likes](https://img.shields.io/pub/likes/riff_switch?logo=dart&color=red)](https://pub.dev/packages/riff_switch/score)
<a href="https://github.com/kenresoft/riff_switch">![Star on Github](https://img.shields.io/github/stars/kenresoft/riff_switch.svg?style=flat&logo=github&colorB=deeppink&label=stars)</a>
<a href="https://github.com/Solido/awesome-flutter">![Awesome Flutter](https://img.shields.io/badge/Awesome-Flutter-blue.svg?longCache=true&style=flat-square)</a>
<a href="https://opensource.org/license/bsd-3-clause">![License: BSD](https://img.shields.io/badge/license-BSD_3--Clause-teal.svg)</a>

Breathe life into your Flutter UI with _**RiffSwitch**_, the switch library that empowers effortless sliding effects and captivating animations. 
Customize the sliding behavior for a unique user experience, while interactive dragging fosters a sense of control and responsiveness. 
Witness smooth state transitions as the switch flips, adding a touch of visual polish to your app. 
Whether you prefer simple or decorative switch types, _**RiffSwitch**_ seamlessly integrates into your UI, 
transforming basic interactions into engaging experiences.

Experience seamless transitions and engaging interactions with _**RiffSwitch**_.

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [Features](#features)
- [Examples](#examples)
- [Screenshots](#screenshots)
- [Contributing](#contributing)
- [License](#license)

## Installation

To use RiffSwitch in your Flutter project, add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  riff_switch: ^0.0.3
```
Then, run:

```bash
flutter pub get
````

## Usage

Import the package:

```dart 
import 'package:riff_switch/riff_switch.dart';
```

Add the RiffSwitch widget to your UI, providing the necessary parameters:

```dart
RiffSwitch(
  value: _isEnabled,
  onChanged: (bool newValue) {
    setState(() {
      _isEnabled = newValue;
    });
  },
  // Additional customization options...
)

```

## Features

* **Customization**: Customize the appearance with various options such as colors, texts, and child widgets.
* **Sliding Effects**: RiffSwitch supports sliding effects for a modern and interactive user experience.
* **Enum Types**: Choose between simple and decorative switch types based on your UI requirements.
* **Animation**:
  * **Smooth Transitions**: Enjoy smooth animations when the switch transitions between on and off states. 
  * **Interactive Dragging**: The sliding effects are accompanied by interactive dragging animations for a responsive feel.

## Examples

Here's a basic example of how to use RiffSwitch:
```dart
import 'package:flutter/material.dart';
import 'package:riff_switch/riff_switch.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('RiffSwitch Example'),
        ),
        body: Center(
          child: RiffSwitch(
            value: true,
            onChanged: (bool newValue) {
              // Handle switch state change
            },
            // Additional customization options...
          ),
        ),
      ),
    );
  }
}

```
More examples from [main.dart](example/lib/main.dart)
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


## Screenshots

<img alt="Screenshot 1" height="500" src="https://github.com/kenresoft/riff_switch/blob/master/screenshots/Screenshot_1.png?raw=true" title="Screenshot 1" width="200"/>

<img alt="Screenshot 2" height="500" src="https://github.com/kenresoft/riff_switch/blob/master/screenshots/Screenshot_2.png?raw=true" title="Screenshot 2" width="200"/>

<img alt="Screen Record 1" height="500" src="https://github.com/kenresoft/riff_switch/blob/master/screenshots/Screen_recording_1.gif?raw=true" title="Screen Record 1" width="200"/>

<img alt="Screen Record 2" height="500" src="https://github.com/kenresoft/riff_switch/blob/master/screenshots/Screen_recording_2.gif?raw=true" title="Screen Record 2" width="200"/>


## Contributing
Contributions are welcome! Feel free to open issues or submit pull requests.

## License
This project is licensed under the BSD 3-Clause License - see the [LICENSE](LICENSE) file for details.
