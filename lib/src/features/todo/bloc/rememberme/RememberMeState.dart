import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable

class Remembermestate extends Equatable {
  final String email;
  final String password;
  final bool rememberMe;
  final bool isSubmitting;
  final String? errorMessage;

  const Remembermestate({
    required this.email,
    required this.password,
    required this.rememberMe,
    this.isSubmitting = false,
    this.errorMessage,
  });

  factory Remembermestate.initial() => const Remembermestate(
    email: '',
    password: '',
    rememberMe: false,
  );

  Remembermestate copyWith({
    String? email,
    String? password,
    bool? rememberMe,
    bool? isSubmitting,
    String? errorMessage,
  }) {
    return Remembermestate(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    rememberMe,
    isSubmitting,
    errorMessage,
  ];
}
