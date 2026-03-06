import 'package:get/get.dart';

import 'english.dart';
import 'indonesian.dart';
import 'mandarin.dart';

class LocalizationTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': englishTranslations,
        'id_ID': indonesianTranslations,
        'zh_CN': mandarinTranslations,
      };
}
