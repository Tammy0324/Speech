// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance;
  }

  static S maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `new_audio_microphone_permission_not_granted`
  String get new_audio_microphone_permission_not_granted {
    return Intl.message(
      'new_audio_microphone_permission_not_granted',
      name: 'new_audio_microphone_permission_not_granted',
      desc: '',
      args: [],
    );
  }

  /// `new_audio_codec`
  String get new_audio_codec {
    return Intl.message(
      'new_audio_codec',
      name: 'new_audio_codec',
      desc: '',
      args: [],
    );
  }

  /// `new_audio_codec_loading_error`
  String get new_audio_codec_loading_error {
    return Intl.message(
      'new_audio_codec_loading_error',
      name: 'new_audio_codec_loading_error',
      desc: '',
      args: [],
    );
  }

  /// `new_audio_codec_loading`
  String get new_audio_codec_loading {
    return Intl.message(
      'new_audio_codec_loading',
      name: 'new_audio_codec_loading',
      desc: '',
      args: [],
    );
  }

  /// `new_audio_AppBare`
  String get new_audio_AppBar {
    return Intl.message(
      'new_audio_AppBare',
      name: 'new_audio_AppBar',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
