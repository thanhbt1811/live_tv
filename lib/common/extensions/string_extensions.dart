const _nameRegex = r'\p{L}+';

extension StringExtensions on String {
  String get shortenedName {
    final regex = RegExp(_nameRegex, unicode: true);
    final fullNameMatches = regex.allMatches(this);
    final nameBuffer = StringBuffer();
    for (final match in fullNameMatches) {
      nameBuffer
        ..write(match.group(0))
        ..write(' ');
    }

    final convertName = nameBuffer
        .toString()
        .trim()
        .split(' ')
        .map((e) => e.isNotEmpty ? e.substring(0, 1) : '')
        .toList();
    if (convertName.length > 2) {
      return '${convertName.first}${convertName.last}'.toUpperCase();
    } else {
      return '${convertName.join('')}'.toUpperCase();
    }
  }
}
