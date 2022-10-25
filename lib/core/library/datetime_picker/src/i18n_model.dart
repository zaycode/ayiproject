enum LocaleType { en, ar }

final _i18nModel = <LocaleType, Map<String, Object>>{
  LocaleType.en: {
    'cancel': 'Cancel',
    'done': 'Done',
    'today': 'Today',
    'monthShort': [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ],
    'monthLong': [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ],
    'day': ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'],
    'am': 'AM',
    'pm': 'PM'
  },
  LocaleType.ar: {
    'cancel': 'إنهاء',
    'done': 'تأكيد',
    'today': 'اليوم',
    'monthShort': [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ],
    'monthLong': [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ],
    'day': ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'],
    'am': 'AM',
    'pm': 'PM'
  }
};

/// Get international object for [localeType]
Map<String, Object> i18nObjInLocale(LocaleType? localeType) =>
    _i18nModel[localeType] ?? _i18nModel[LocaleType.en] as Map<String, Object>;

/// Get international lookup for a [localeType], [key] and [index].
String i18nObjInLocaleLookup(LocaleType localeType, String key, int index) {
  final i18n = i18nObjInLocale(localeType);
  final i18nKey = i18n[key] as List<String>;
  return i18nKey[index];
}
