import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'captcha_event.dart';
part 'captcha_state.dart';

class CaptchaBloc extends Bloc<CaptchaEvent, CaptchaState> {
  CaptchaBloc() : super(PreCaptcha());

  @override
  Stream<CaptchaState> mapEventToState(
    CaptchaEvent event,
  ) async* {
    if (event is ShowCaptcha) {
      yield OnCaptcha();
    }

    if (event is SubmitCaptchaResponse && state is OnCaptcha) {
      yield CaptchaSubmitted(result: event.result);
    }
  }
}
