part of 'captcha_bloc.dart';

abstract class CaptchaState extends Equatable {
  const CaptchaState();

  @override
  List<Object> get props => [];
}

class PreCaptcha extends CaptchaState {}

class OnCaptcha extends CaptchaState {}

class CaptchaSubmitted extends CaptchaState {
  final String result;

  const CaptchaSubmitted({required this.result});

  @override
  List<Object> get props => [result];
}