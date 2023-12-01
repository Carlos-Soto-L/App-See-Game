class Utils {
 static String? extractVideoId(String url) {
  RegExp regExp = RegExp(
    r"(?<=v=|v\/|vi=|vi\/|youtu\.be\/)[^#&?]*",
    caseSensitive: false,
    multiLine: false,
  );

  RegExpMatch? match = regExp.firstMatch(url);
  return match?.group(0);
}
}