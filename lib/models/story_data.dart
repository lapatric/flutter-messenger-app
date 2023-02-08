import 'package:meta/meta.dart';

@immutable // immutable: Once this model is set, it cannot be changed
class StoryData {
  const StoryData({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;
}
