String getFirstLetter(String letters, {int length = 2}) {
  List<String> words = letters.split(' ');
  String result = '';

  for (var word in words) {
    result += word[0];
  }

  return (result.length > length ? result.substring(0, length) : result)
      .toUpperCase();
}
