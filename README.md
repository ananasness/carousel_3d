<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# 3D carousel

## Features

The package provides a widget that displays user data as 3d carousel

## Getting started

1. Add package to pubspec.yaml
```carousel_3d: 1.0.0```

2. Import it to file where it is going to be used

3. Create carousel_3d and provide required attributes

```dart
Carousel3d(
          center: _center,
          items: [
          <items to display>
          ],
        ),
```
Where center is a state that controls which element is central in carousel.
By changing center the carousel is rotated so that any event can be associated with carousel rotation

## Usage

Display 5 different images in carousel

```dart
  Image.assets('assets/img_1.png'),
            Image.assets('assets/img_2.png'),
            Image.assets('assets/img_3.png'),
            Image.assets('assets/img_4.png'),
            Image.assets('assets/img_5.png'),
```

## Additional information
 Parameters:
`center` - index of the current central element
`items` - widgets to display in cerousel
`duration` - duration of carousel animations
'displayRadius' - how much items displayed on each side from cental item
