# Messenger App UI

This repo follows the following youtube tutorial: https://youtu.be/vgqBc7jni8c. To begin project we run the following set of commands. 

```bash
flutter create messenger_app
```

## Theme

The theme of the application is controlled inside `lib/theme.dart`. This AppTheme class constains two functions `light()` and `dark()` which both return a `ThemeData` widget.

### Google Fonts

In order to have access to all Google Fonts we add a dependency in the `pubspec.yaml` file as follows.

```yaml
dependencies:
  google_fonts: ^4.0.3
```
We can then make use of `GoogleFonts` to choose a font family, e.g. `GoogleFonts.mulishTextTheme()` (see `lib/theme.dart`).

