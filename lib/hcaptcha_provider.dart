library hcaptcha;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/captcha_bloc.dart';

/// A container class that gets injected to the widget tree and provides the
/// [Captcha] widget with all the data it needs to work (ie. The URL), along with
/// additional data that the user might want to store (data from a form).
class CaptchaDataContainer {
  final String captchaURL;
  final Map<String, dynamic> data = <String, dynamic>{};

  CaptchaDataContainer({required this.captchaURL});

  void addData({required String key, required dynamic dataIn}) =>
      data[key] = dataIn;

  dynamic getData({required String key}) => data[key];

  bool hasData({required String key}) => data.containsKey(key);
}

typedef CaptchaCompleteFunction = Function(
    String result, CaptchaBloc bloc, CaptchaDataContainer cdc);

class _CaptchaBuilder extends StatelessWidget {
  final Widget onCaptcha;
  final Widget preCaptcha;
  final CaptchaCompleteFunction onCaptchaCompleted;

  _CaptchaBuilder(
      {required this.onCaptcha,
      required this.preCaptcha,
      required this.onCaptchaCompleted});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CaptchaBloc, CaptchaState>(
      listener: (context, state) {
        if (state is CaptchaSubmitted)
          onCaptchaCompleted(state.result, context.read<CaptchaBloc>(),
              context.read<CaptchaDataContainer>());
      },
      child: BlocBuilder<CaptchaBloc, CaptchaState>(
        builder: (context, state) {
          if (state is OnCaptcha) return onCaptcha;

          return preCaptcha;
        },
      ),
    );
  }
}

class HCaptchaProvider extends StatelessWidget {
  final Widget onPreCaptcha;
  final Widget onCaptcha;
  final String captchaUrl;
  final CaptchaCompleteFunction onCaptchaCompleted;

  HCaptchaProvider(
      {required this.captchaUrl,
      required this.onPreCaptcha,
      required this.onCaptcha,
      required this.onCaptchaCompleted});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<CaptchaDataContainer>(
      create: (context) {
        return CaptchaDataContainer(captchaURL: captchaUrl);
      },
      child: BlocProvider<CaptchaBloc>(
        create: (context) {
          return CaptchaBloc();
        },
        child: _CaptchaBuilder(
          onCaptcha: onCaptcha,
          preCaptcha: onPreCaptcha,
          onCaptchaCompleted: onCaptchaCompleted,
        ),
      ),
    );
  }
}
