class TextUtils {
  static String formatInterval(int? days) {
    if (days == null || days <= 0) return 'Unknown';
    if (days == 1) return 'each day';

    final ordinals = {
      2: 'second',
      3: 'third',
      4: 'fourth',
      5: 'fifth',
      6: 'sixth',
      7: 'seventh',
    };

    final ordinal = ordinals[days] ?? '$days th';
    return 'every $ordinal day';
  }

  static String capitalize(String? text) {
    if (text == null || text.isEmpty) return '';
    if (text.length == 1) return text.toUpperCase();
    return "${text[0].toUpperCase()}${text.substring(1)}";
  }
}
