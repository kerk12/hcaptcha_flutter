part of 'captcha_bloc.dart';

abstract class CaptchaEvent extends Equatable {
  const CaptchaEvent();

  @override
  List<Object> get props => [];
}

class ShowCaptcha extends CaptchaEvent {}

class SubmitCaptchaResponse extends CaptchaEvent {
  final String result;

  const SubmitCaptchaResponse({required this.result});

  @override
  List<Object> get props => [result];
}

class ResetCaptcha extends CaptchaEvent {
  @override
  List<Object> get props => [];
}

