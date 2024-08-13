part of 'localization_bloc.dart';



abstract class LocalizationState{
  const LocalizationState();
}

class LocalizationLocaleState extends LocalizationState{
  final LocaleLibrary locale;
  const LocalizationLocaleState({required this.locale});
}