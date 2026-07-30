class Letter {
  static final List<Map<String, String>> letterOptions = [
    {'en': 'A', 'ar': 'ا'},
    {'en': 'B', 'ar': 'ب'},
    {'en': 'J', 'ar': 'ح'},
    {'en': 'D', 'ar': 'د'},
    {'en': 'R', 'ar': 'ر'},
    {'en': 'S', 'ar': 'س'},
    {'en': 'X', 'ar': 'ص'},
    {'en': 'T', 'ar': 'ط'},
    {'en': 'E', 'ar': 'ع'},
    {'en': 'G', 'ar': 'ق'},
    {'en': 'K', 'ar': 'ك'},
    {'en': 'L', 'ar': 'ل'},
    {'en': 'Z', 'ar': 'م'},
    {'en': 'N', 'ar': 'ن'},
    {'en': 'H', 'ar': 'ه'},
    {'en': 'U', 'ar': 'و'},
    {'en': 'V', 'ar': 'ى'},
  ];

  // Add this missing method
  static String convertToArabic(String englishLetter) {
    final letter = letterOptions.firstWhere(
          (e) => e['en'] == englishLetter.toUpperCase(),
      orElse: () => {'ar': ''},
    );
    return letter['ar'] ?? '';
  }

  static String convertTextToArabic(String englishText) {
    if (englishText.trim().isEmpty) return '';

    final List<String> parts = [];
    for (int i = 0; i < englishText.length; i++) {
      final ch = englishText[i];
      if (ch.trim().isEmpty) continue; // skip input spaces
      final arabicLetter = convertToArabic(ch);
      if (arabicLetter.isNotEmpty) {
        parts.add(arabicLetter);
      } else {
        // If no mapping found, keep the original character (optional).
        parts.add(ch);
      }
    }

    // Join with a single space between letters
    return parts.join(' ');
  }
}
