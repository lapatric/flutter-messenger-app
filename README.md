# Messenger App UI

This repo follows the following youtube tutorial: https://youtu.be/vgqBc7jni8c. To begin project we run the following set of commands. 

```bash
flutter create messenger_app
```

## Emulator

To run the emulator press `Ctrl + P` inside VSCode, then type `> Flutter: Launch Emulator` and select your emulator of choice.

## Extensions

To simplify the import of certain packages / dependencies inside our `pubspec.yaml` file, we install the [Pubspec Assist](https://marketplace.visualstudio.com/items?itemName=jeroen-meijer.pubspec-assist) extenions. Then when we want to add a new dependency we simply press `Ctrl + P`, type `> Pubspec Assist: ...` and select whether we want to add a dependency or dev dependency.

### Google Fonts

In order to have access to all Google Fonts we add a dependency in the `pubspec.yaml` file as follows.

```yaml
dependencies:
  google_fonts: ^4.0.3
```
We can then make use of `GoogleFonts` to choose a font family, e.g. `GoogleFonts.mulishTextTheme()` (see `lib/theme.dart`).

## Theme

The theme of the application is controlled inside `lib/theme.dart`. This AppTheme class constains two functions `light()` and `dark()` which both return a `ThemeData` widget.

## SetState() Alternative

In some instances we do not want to use setState(). This is because setState() rebuilds all widgets, when it could be that we only want to redraw one text field. In other instances, setState isn't applicable because we're in a stateless widget. 

In such cases we may use the `ValueNotifier<T>` together with the `ValueListenableBuilder`. This can be done as follows.

1. Create a variable that holds a value and can be listened to when it's state changes, in order to rebuild the widget. 
  ```final ValueNotifier<int> pageIndex = ValueNotifier(0);```
2. Now we can use the `ValueListenableBuilder` to rebuild only a specific widget when the value of our ValueNotifier changes. The   widget it rebuilds must be returned by the function specified in its `builder` field.   
          ```dart
              ValueListenableBuilder(
              valueListenable: pageIndex,
              builder: (BuildContext context, int value, _) {
                  return pages[value] // indexes into a list of widgets;
              },
            )
          ```
3. Finally, the value of our `ValueNotifier` can be changed. This in turns triggers any listening builders to rebuild their widgets.
        ```dart 
            pageIndex.value = value;
        ```

## Creating a Glowing Action Button

To showcase a snippet of the code that forms this app, we show how one may implement a glowing action button. The key to note here is that essentially any widget can be made clickable by assigning a function to the `onTap` function. 

```dart
import 'package:messenger_app/theme.dart';
import 'package:flutter/material.dart';

class GlowingActionButton extends StatelessWidget {
  const GlowingActionButton({
    Key? key,
    required this.color,
    required this.icon,
    this.size = 54,
    required this.onPressed,
  }) : super(key: key);

  final Color color;
  final IconData icon;
  final double size;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          // glowing affect
          BoxShadow(
            color: color.withOpacity(0.3),
            spreadRadius: 10,
            blurRadius: 24,
          ),
        ],
      ),
      child: ClipOval(
        child: Material(
          color: color,
          child: InkWell(
            splashColor: AppColors.cardLight,
            onTap: onPressed,
            child: SizedBox(
              width: size,
              height: size,
              child: Icon(
                icon,
                size: 26,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

Furthermoe, one may observe the use of `decoration: BoxDecoration()`. This is a useful field to add borders or glowing affects to widgets, e.g. it can also be used to add dividers: 

```dart
decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2)))
```

- Without `Expanded`, `Column` doesn't know how big to be, hence we wrap it in the former: 
        ```dart
        body: Column(
                children: const [Expanded(child: _DemoMessageList()), _ActionBar()],
              ),
        ```
- Page Navigation:...