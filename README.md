# hCaptcha Flutter

During one of the projects I was working on, I found out that there aren't any "solid enough" captcha implementations in Flutter.

After following [https://medium.com/@hCaptcha/implementing-hcaptcha-in-your-flutter-app-13ea6ddca71b](this official guide) on [https://www.hcaptcha.com/](hCaptcha), I decided to make an
"all-in-one" solution, that takes care of the state and widgets.

## Features:

- Uses Flutter BLOC to manage the state.
- Provides a class for adding any of your data (eg form data) when solving the captcha.

## Captcha HTML Page creation:

For this package to work, we assume that the app you're developing client-server based, meaning that there's a backend to support it.

Before you take care of the package installation and implementation, you'll need to add a simple HTML page to your server:

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

This page takes care of serving your Captcha to your mobile device. In this case, we'll assume that the URL pointing to this page is `myapp.kgiannakis.me/captcha-challenge`.

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
