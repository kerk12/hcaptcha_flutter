# hCaptcha Flutter

During one of the projects I was working on, I found out that there aren't any "solid enough" captcha implementations in Flutter.

After following [https://medium.com/@hCaptcha/implementing-hcaptcha-in-your-flutter-app-13ea6ddca71b](this official guide) 
on [https://www.hcaptcha.com/](hCaptcha), I decided to make an "all-in-one" solution, that takes care
 of the state and widgets needed to get HCaptcha Working with your flutter project.
 
This Repository is part of the **Hacktoberfest 2021** challenge! If it seems kind of empty, it's because it's intentionally left this way.
Take a look at the issues tab for stuff that needs doing, and earn yourself a free T-Shirt along the way! 

## Features:

- Uses Flutter BLOC to manage the state.
- Provides a class for adding any of your data (eg form data) when solving the captcha.

## Captcha HTML Page creation:

For this package to work, we assume that the app you're developing client-server based, meaning that
there's a backend to support it.

Before you take care of the package installation and implementation, you'll need to add a simple HTML
page to your server (Don't forget to add your secret key!!!):

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Captcha Challenge</title>
    </head>

    <body>
        <div style="display: flex; justify-content: center;">
            <form method="POST">
                <div class="h-captcha" data-sitekey="YOUR_SECRET_GOES_HERE" data-callback="captchaCallback"></div>
                <script src="https://js.hcaptcha.com/1/api.js" async defer></script>
            </form>
        </div>

        <script>
            function captchaCallback(response) {
                if (typeof Captcha!=="undefined") {
                    Captcha.postMessage(response);
                }
            }
        </script>
    </body>
</html>
```

This page takes care of serving your Captcha to your mobile device. The `Captcha` thing inside the 
`<script>` is where the magic happens. This is a [JavaScript Channel](https://developer.mozilla.org/en-US/docs/Web/API/MessageChannel)
and its job is to pass the data back to the Flutter App, using the integrated WebView 
(which we'll set up in the next step).

In this case, we'll assume that the URL pointing to this page is `myapp.kgiannakis.me/captcha-challenge`.

## Installation:

**Note:** For now and until most of the scaffolding work of the project is complete, in terms of documentation and such, the project will only be published here and not on pub.dev.

1. Clone this plugin to a directory of your choice.

2. Include it in your pubspec file:

```yaml
dependencies:
  ...
  hcaptcha_flutter:
    path: ../hcaptcha_flutter
```

3. Create a `HCaptchaProvider`:

```dart
HCaptchaProvider(
  captchaUrl: "https://myapp.kgiannakis.me/captcha-challenge",
  onPreCaptcha: const SomeForm(),
  onCaptcha: const CaptchaScreen(),
  onCaptchaCompleted: (result, cbloc, data) {
    // This is the part where you pass the result to the server for verification
    final username = data.getData(key: "username");
    log(result);
    log(username);
  })
```

This provides the scaffolding work of the captcha process. It injects a `CaptchaBloc` to the widget
tree along with a `CaptchaDataContainer`. Think of the data container as a method to temporarily store
stuff when dealing with a captcha challenge.

4. Inside your form, add the Captcha Logic when submitting:

```dart
if (_formKey.currentState!.validate()) {
  // Add the username to the data container.
  var dataContainer = CaptchaUtils.getDataContainer(context);
  dataContainer.addData(
      key: "username", dataIn: _usernameController.value.text);

  // This advances the user to the second step (the challenge)
  CaptchaUtils.goToCaptcha(context);
}
```

5. Finally, add the `HCaptcha` widget itself:

```dart
class CaptchaScreen extends StatelessWidget {
  const CaptchaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 450),
      child: HCaptcha(),
    );
  }
}
```

6. When the challenge has been completed by the user, the callback in step 3 (`onCaptchaCompleted`) 
will be called. You can then pass on the result to your backend for [verification](https://docs.hcaptcha.com/#verify-the-user-response-server-side).