/*
 * Generated file. Do not edit.
 *
 * Locales: 2
 * Strings: 16 (8.0 per locale)
 *
 * Built on 2023-06-17 at 14:42 UTC
 */

import 'package:flutter/widgets.dart';

const AppLocale _baseLocale = AppLocale.en;
AppLocale _currLocale = _baseLocale;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale {
  en, // 'en' (base locale, fallback)
  ja, // 'ja'
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
TranslationsEn _t = _currLocale.translations;
TranslationsEn get t => _t;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class Translations {
  Translations._(); // no constructor

  static TranslationsEn of(BuildContext context) {
    final inheritedWidget =
        context.dependOnInheritedWidgetOfExactType<InheritedLocaleData>();
    if (inheritedWidget == null) {
      throw 'Please wrap your app with "TranslationProvider".';
    }
    return inheritedWidget.translations;
  }
}

class LocaleSettings {
  LocaleSettings._(); // no constructor

  /// Uses locale of the device, fallbacks to base locale.
  /// Returns the locale which has been set.
  static AppLocale useDeviceLocale() {
    final locale = AppLocaleUtils.findDeviceLocale();
    return setLocale(locale);
  }

  /// Sets locale
  /// Returns the locale which has been set.
  static AppLocale setLocale(AppLocale locale) {
    _currLocale = locale;
    _t = _currLocale.translations;

    // force rebuild if TranslationProvider is used
    _translationProviderKey.currentState?.setLocale(_currLocale);

    return _currLocale;
  }

  /// Sets locale using string tag (e.g. en_US, de-DE, fr)
  /// Fallbacks to base locale.
  /// Returns the locale which has been set.
  static AppLocale setLocaleRaw(String rawLocale) {
    final locale = AppLocaleUtils.parse(rawLocale);
    return setLocale(locale);
  }

  /// Gets current locale.
  static AppLocale get currentLocale {
    return _currLocale;
  }

  /// Gets base locale.
  static AppLocale get baseLocale {
    return _baseLocale;
  }

  /// Gets supported locales in string format.
  static List<String> get supportedLocalesRaw {
    return AppLocale.values.map((locale) => locale.languageTag).toList();
  }

  /// Gets supported locales (as Locale objects) with base locale sorted first.
  static List<Locale> get supportedLocales {
    return AppLocale.values.map((locale) => locale.flutterLocale).toList();
  }
}

/// Provides utility functions without any side effects.
class AppLocaleUtils {
  AppLocaleUtils._(); // no constructor

  /// Returns the locale of the device as the enum type.
  /// Fallbacks to base locale.
  static AppLocale findDeviceLocale() {
    final String deviceLocale =
        WidgetsBinding.instance.platformDispatcher.locale.toLanguageTag();
    final AppLocale? typedLocale = _selectLocale(deviceLocale);

    // typedLocaleがnullの場合、_baseLocaleを返す
    return typedLocale ?? _baseLocale;
  }

  /// Returns the enum type of the raw locale.
  /// Fallbacks to base locale.
  static AppLocale parse(String rawLocale) {
    return _selectLocale(rawLocale) ?? _baseLocale;
  }
}

// context enums

// interfaces generated as mixins

// translation instances

TranslationsEn _translationsEn = TranslationsEn.build();
_TranslationsJa _translationsJa = _TranslationsJa.build();

// extensions for AppLocale

extension AppLocaleExtensions on AppLocale {
  /// Gets the translation instance managed by this library.
  /// [TranslationProvider] is using this instance.
  /// The plural resolvers are set via [LocaleSettings].
  TranslationsEn get translations {
    switch (this) {
      case AppLocale.en:
        return _translationsEn;
      case AppLocale.ja:
        return _translationsJa;
    }
  }

  /// Gets a new translation instance.
  /// [LocaleSettings] has no effect here.
  /// Suitable for dependency injection and unit tests.
  ///
  /// Usage:
  /// final t = AppLocale.en.build(); // build
  /// String a = t.my.path; // access
  TranslationsEn build() {
    switch (this) {
      case AppLocale.en:
        return TranslationsEn.build();
      case AppLocale.ja:
        return _TranslationsJa.build();
    }
  }

  String get languageTag {
    switch (this) {
      case AppLocale.en:
        return 'en';
      case AppLocale.ja:
        return 'ja';
    }
  }

  Locale get flutterLocale {
    switch (this) {
      case AppLocale.en:
        return const Locale.fromSubtags(languageCode: 'en');
      case AppLocale.ja:
        return const Locale.fromSubtags(languageCode: 'ja');
    }
  }
}

extension StringAppLocaleExtensions on String {
  AppLocale? toAppLocale() {
    switch (this) {
      case 'en':
        return AppLocale.en;
      case 'ja':
        return AppLocale.ja;
      default:
        return null;
    }
  }
}

// wrappers

GlobalKey<TranslationProviderState> _translationProviderKey =
    GlobalKey<TranslationProviderState>();

class TranslationProvider extends StatefulWidget {
  TranslationProvider({required this.child})
      : super(key: _translationProviderKey);

  final Widget child;

  @override
  TranslationProviderState createState() => TranslationProviderState();

  static InheritedLocaleData of(BuildContext context) {
    final inheritedWidget =
        context.dependOnInheritedWidgetOfExactType<InheritedLocaleData>();
    if (inheritedWidget == null) {
      throw 'Please wrap your app with "TranslationProvider".';
    }
    return inheritedWidget;
  }
}

class TranslationProviderState extends State<TranslationProvider> {
  AppLocale locale = _currLocale;

  void setLocale(AppLocale newLocale) {
    setState(() {
      locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InheritedLocaleData(
      locale: locale,
      child: widget.child,
    );
  }
}

class InheritedLocaleData extends InheritedWidget {
  final AppLocale locale;
  Locale get flutterLocale => locale.flutterLocale; // shortcut
  final TranslationsEn translations; // store translations to avoid switch call

  InheritedLocaleData(
      {Key? key, // 追加されたkeyパラメータ
      required this.locale,
      required Widget child})
      : translations = locale.translations,
        super(key: key, child: child); // super constructorにkeyを渡す

  @override
  bool updateShouldNotify(InheritedLocaleData oldWidget) {
    return oldWidget.locale != locale;
  }
}

// pluralization feature not used

// helpers

final _localeRegex =
    RegExp(r'^([a-z]{2,8})?([_-]([A-Za-z]{4}))?([_-]?([A-Z]{2}|[0-9]{3}))?$');
AppLocale? _selectLocale(String localeRaw) {
  final match = _localeRegex.firstMatch(localeRaw);
  AppLocale? selected;
  if (match != null) {
    final language = match.group(1);
    final country = match.group(5);

    // match exactly
    selected = AppLocale.values.cast<AppLocale?>().firstWhere(
        (supported) => supported?.languageTag == localeRaw.replaceAll('_', '-'),
        orElse: () => null);

    if (selected == null && language != null) {
      // match language
      selected = AppLocale.values.cast<AppLocale?>().firstWhere(
          (supported) => supported?.languageTag.startsWith(language) == true,
          orElse: () => null);
    }

    if (selected == null && country != null) {
      // match country
      selected = AppLocale.values.cast<AppLocale?>().firstWhere(
          (supported) => supported?.languageTag.contains(country) == true,
          orElse: () => null);
    }
  }
  return selected;
}

// translations

// Path: <root>
class TranslationsEn {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsEn.build();

  /// Access flat map
  dynamic operator [](String key) => _flatMap[key];

  // Internal flat map initialized lazily
  late final Map<String, dynamic> _flatMap = _buildFlatMap();

  late final TranslationsEn _root = this; // ignore: unused_field

  // Translations
  String get hello => 'You can search repositories';
  String get search => 'Search';
  String get error => 'An invalid request has been sent.';
  String get none => 'No repositories were found';
  String get result => 'repositories found';
  String get open => 'Open the repository';
  String get make => '-Create to';
  String get update => '-Last updated on';
}

// Path: <root>
class _TranslationsJa implements TranslationsEn {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  _TranslationsJa.build();

  /// Access flat map
  @override
  dynamic operator [](String key) => _flatMap[key];

  // Internal flat map initialized lazily
  @override
  late final Map<String, dynamic> _flatMap = _buildFlatMap();

  @override
  late final _TranslationsJa _root = this; // ignore: unused_field

  // Translations
  @override
  String get hello => 'リポジトリを検索できます';
  @override
  String get search => '検索';
  @override
  String get error => '不正なリクエストが送信されました。';
  @override
  String get none => 'リポジトリが見つかりませんでした';
  @override
  String get result => '件のリポジトリが見つかりました';
  @override
  String get open => 'リポジトリを開く';
  @override
  String get make => 'に作成';
  @override
  String get update => 'に最終更新';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on TranslationsEn {
  Map<String, dynamic> _buildFlatMap() {
    return <String, dynamic>{
      'hello': 'You can search repositories',
      'search': 'Search',
      'error': 'An invalid request has been sent.',
      'none': 'No repositories were found',
      'result': 'repositories found',
      'open': 'Open the repository',
      'make': '-Create to',
      'update': '-Last updated on',
    };
  }
}

extension on _TranslationsJa {
  Map<String, dynamic> _buildFlatMap() {
    return <String, dynamic>{
      'hello': 'リポジトリを検索できます',
      'search': '検索',
      'error': '不正なリクエストが送信されました。',
      'none': 'リポジトリが見つかりませんでした',
      'result': '件のリポジトリが見つかりました',
      'open': 'リポジトリを開く',
      'make': 'に作成',
      'update': 'に最終更新',
    };
  }
}
