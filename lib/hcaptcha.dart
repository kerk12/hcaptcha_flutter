library hcaptcha;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'bloc/captcha_bloc.dart';
import 'hcaptcha_provider.dart';

// ignore: must_be_immutable
class HCaptcha extends StatelessWidget {
  late CaptchaDataContainer _cdc;

  @override
  Widget build(BuildContext context) {
    _cdc = RepositoryProvider.of<CaptchaDataContainer>(context);

    return WebView(
      initialUrl: _cdc.captchaURL,
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: <JavascriptChannel>{
        JavascriptChannel(name: "Captcha", onMessageReceived: (message) {
          var bloc = BlocProvider.of<CaptchaBloc>(context);
          bloc.add(SubmitCaptchaResponse(result: message.message));
        })
      });
  }
}
