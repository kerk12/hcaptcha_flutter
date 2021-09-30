library hcaptcha;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'hcaptcha_provider.dart';
import 'bloc/captcha_bloc.dart';

class CaptchaUtils {
  _CaptchaUtils(){}

  static void goToCaptcha(BuildContext context) {
    var cbloc = BlocProvider.of<CaptchaBloc>(context);
    cbloc.add(ShowCaptcha());
  }

  static CaptchaDataContainer getDataContainer(BuildContext context){
    return RepositoryProvider.of<CaptchaDataContainer>(context);
  }
}
