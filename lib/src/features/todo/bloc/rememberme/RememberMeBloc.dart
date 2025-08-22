import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/data/data_sources/app_shared_prefs.dart';
import 'RememberMeEvent.dart';
import 'RememberMeState.dart';
class Remembermebloc extends Bloc<Remembermeevent, Remembermestate> {
  final AppSharedPrefs sharedPrefs;

  Remembermebloc({required this.sharedPrefs}) : super(Remembermestate.initial()) {
    on<LoadSavedCredentials>(_onLoadSavedCredentials);
    on<EmailChanged>((event, emit) => emit(state.copyWith(email: event.email)));
    on<PasswordChanged>((event, emit) => emit(state.copyWith(password: event.password)));
    on<RememberMeToggled>((event, emit) => emit(state.copyWith(rememberMe: event.value)));
    on<SubmitLogin>(_onSubmitLogin);
  }

  Future<void> _onLoadSavedCredentials(LoadSavedCredentials event, Emitter<Remembermestate> emit) async {
    final rememberMe = sharedPrefs.getRememberMe();
    final email = sharedPrefs.getSavedEmail();
    final password = sharedPrefs.getSavedPassword();

    if (rememberMe) {
      emit(state.copyWith(email: email, password: password, rememberMe: true));
    }
  }

  Future<void> _onSubmitLogin(SubmitLogin event, Emitter<Remembermestate> emit) async {
    emit(state.copyWith(isSubmitting: true));

    await Future.delayed(Duration(seconds: 1));

    if (state.email.isNotEmpty && state.password.isNotEmpty) {
      if (state.rememberMe) {
        await sharedPrefs.saveCredentials(
          email: state.email,
          password: state.password,
          rememberMe: state.rememberMe,
        );
      } else {
        await sharedPrefs.clearCredentials();
      }

      emit(state.copyWith(isSubmitting: false));
    } else {
      emit(state.copyWith(isSubmitting: false, errorMessage: "Invalid credentials"));
    }
  }
}
