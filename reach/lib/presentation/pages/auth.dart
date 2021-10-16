import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:reach/config/themes.dart';
import 'package:reach/presentation/widgets/buttons.dart';

/// allows for user authentication using google & twitter.
/// it uses the auth bloc to achieve this purpose.
class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    /// dimensions of the current display
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    /// text theme of the application
    var textTheme = Theme.of(context).textTheme;

    /// color scheme of the application
    var colorScheme = Theme.of(context).colorScheme;

    /// set system UI overlays when the application is rendered
    /// to the user's display.
    kApplySystemOverlay(
      context,
      statusBarColor: colorScheme.background,
      statusBarIconBrightness: Brightness.dark,
    );

    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// image
            Container(
              width: width,
              height: height * 0.4,
              // child: Lottie.network('https://assets4.lottiefiles.com/packages/lf20_xyadoh9h.json'),
              child: Lottie.asset('assets/user_profile_card.json'),
            ),

            /// text
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 16),
              child: Text(
                'Make your brand known',
                style: textTheme.headline5,
              ),
            ),

            /// text
            Padding(
              padding: EdgeInsets.only(
                bottom: 40,
                left: width * 0.1,
                right: width * 0.1,
              ),
              child: Text(
                'Create and share your brand with 100M users across the world',
                style: textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ),

            /// button
            // MaterialButton(
            //   onPressed: () {},
            //   child: Text("Sign in with Google"),
            // ),
            const PrimaryButton(
              label: 'Sign in with Google',
              icon: FontAwesomeIcons.google,
              outline: true,
            ),

            const SizedBox(height: 16),

            /// button
            // MaterialButton(
            //   onPressed: () {},
            //   child: Text("Sign in with Twitter"),
            // ),
            const PrimaryButton(
              label: 'Sign in with Twitter',
              icon: FontAwesomeIcons.twitter,
              background: Colors.blue,
              foreground: Colors.white,
            ),

            /// text button
            TextButton(
              onPressed: () {
                /// todo -> show terms & conditions
              },
              child: Text(
                'Terms & conditions',
                style: textTheme.button?.copyWith(
                  color: colorScheme.onBackground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
