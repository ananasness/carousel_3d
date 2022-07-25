# 3D carousel

The package provides a widget that displays user data as 3d carousel
![](https://github.com/ananasness/carousel_3d/blob/master/images/cards.gif)

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
        )
```
Where center is a state that controls which element is central in carousel.
By changing center the carousel is rotated so that any event can be associated with carousel rotation

## Usage

Display 5 different images in carousel

```dart
Carousel3d(
          center: _center,
          items: [
            Image.assets('assets/img_1.png'),
                      Image.asset('assets/img_2.png'),
                      Image.asset('assets/img_3.png'),
                      Image.asset('assets/img_4.png'),
                      Image.asset('assets/img_5.png'),
          ],
        )
```

Result

![](https://github.com/ananasness/carousel_3d/blob/master/images/images.gif)

## Additional information
 Parameters:
`center` - index of the current central element <br>
`items` - widgets to display in carousel<br>
`duration` - duration of carousel animations<br>
'displayRadius' - how much items displayed on each side from central item<br>
