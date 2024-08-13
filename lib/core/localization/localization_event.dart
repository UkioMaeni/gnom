part of 'localization_bloc.dart';

abstract class LocalizationEvent{
  const LocalizationEvent();
}

class LocalizationSetLocaleEvent extends LocalizationEvent{
  final LocaleLibrary locale;
  LocalizationSetLocaleEvent({required this.locale});
}