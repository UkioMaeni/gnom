
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnom/core/localization/custom_localization.dart';

part 'localization_state.dart';
part 'localization_event.dart';

class LocalizationBloc extends Bloc<LocalizationEvent,LocalizationLocaleState>{
  LocalizationBloc():super(LocalizationLocaleState(locale: EnLocale())){
    on<LocalizationSetLocaleEvent>((event, emit)async{
      emit( LocalizationLocaleState(locale:event.locale));
      print(event.locale);
    });

  }
  
}