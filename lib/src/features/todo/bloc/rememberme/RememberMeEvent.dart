
import 'package:equatable/equatable.dart';

abstract class Remembermeevent extends Equatable {
  Remembermeevent();

  @override
  List<Object?> get props => [];
}

class LoadSavedCredentials extends Remembermeevent {}

class EmailChanged extends Remembermeevent {
  final String email;

   EmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class PasswordChanged extends Remembermeevent {
  final String password;

   PasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class RememberMeToggled extends Remembermeevent {
  final bool value;

   RememberMeToggled(this.value);

  @override
  List<Object?> get props => [value];
}

class SubmitLogin extends Remembermeevent {}