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
  riff_switch: ^0.0.4
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

> **NOTE**: It's important to note that the `thumbColor` property takes precedence over any color applied directly to the `active` or `inactive` thumb, 
whether through a container widget or any other means.
This allows for consistent and predictable customization of the thumb's color across different states of the switch, 
ensuring a cohesive visual appearance throughout the application.

## Screenshots

| Screenshot 1                                                                                                | Screenshot 2                                                                                                | Screenshot 3                                                                                                |
|-------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------|
| ![Screenshot 1](https://github.com/kenresoft/riff_switch/blob/master/screenshots/Screenshot_1.png?raw=true) | ![Screenshot 2](https://github.com/kenresoft/riff_switch/blob/master/screenshots/Screenshot_2.png?raw=true) | ![Screenshot 3](https://github.com/kenresoft/riff_switch/blob/master/screenshots/Screenshot_3.png?raw=true) |

| Screenshot 4                                                                                                | Screenshot 5                                                                                                | Screenshot 6                                                                                                |
|-------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------|
| ![Screenshot 4](https://github.com/kenresoft/riff_switch/blob/master/screenshots/Screenshot_4.png?raw=true) | ![Screenshot 5](https://github.com/kenresoft/riff_switch/blob/master/screenshots/Screenshot_5.png?raw=true) | ![Screenshot 6](https://github.com/kenresoft/riff_switch/blob/master/screenshots/Screenshot_6.png?raw=true) |

| Screen Record 1                                                                                                      | Screen Record 2                                                                                                      |
|----------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------|
| ![Screen Record 1](https://github.com/kenresoft/riff_switch/blob/master/screenshots/Screen_recording_1.gif?raw=true) | ![Screen Record 2](https://github.com/kenresoft/riff_switch/blob/master/screenshots/Screen_recording_2.gif?raw=true) |


## Contributing
Contributions are welcome! Feel free to open issues or submit pull requests.

- **Issues**: If you encounter any bugs, have feature requests, or want to suggest improvements, please open an issue on our GitHub repository. Provide as much detail as possible to help us understand the problem or idea better.

- **Pull Requests**: If you'd like to contribute code changes, feel free to submit a pull request. Before doing so, make sure to fork the repository and create a new branch for your changes. Follow the existing coding style and guidelines, and write clear and concise commit messages. Your pull request will undergo review, and we'll work together to ensure the changes align with the project's goals.

- **Feature Requests**: If you have ideas for new features or enhancements, please open an issue to discuss them. We value community feedback and want to ensure that new features align with the project's direction and objectives.

- **Spread the Word**: Help us grow the FontResoft community by sharing the project with others. Whether through social media, blog posts, or word of mouth, spreading the word about FontResoft helps attract more users and contributors.

## License
This project is licensed under the BSD 3-Clause License - see the [LICENSE](LICENSE) file for details.
