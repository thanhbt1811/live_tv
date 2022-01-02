import 'package:camera_with_rtmp/camera.dart';
import 'package:flutter_translate/flutter_translate.dart';

extension ResolutionPresetExtensions on ResolutionPreset {
  String get label {
    switch (this) {
      case ResolutionPreset.low:
        return '240p';
      case ResolutionPreset.medium:
        return '360p';
      case ResolutionPreset.high:
        return '720p';
      case ResolutionPreset.veryHigh:
        return '1080p';
      case ResolutionPreset.ultraHigh:
        return '2160p';
      case ResolutionPreset.max:
        return translate('auto');
    }
  }
}
