import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reach/config/themes.dart';
import 'package:reach/presentation/widgets/buttons.dart';

/// authentication page.
/// handles login & registration
class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
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
    kApplySystemOverlay(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: height * 0.1,
                    left: width * 0.1,
                    right: width * 0.1,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          'Make your brand known',
                          style: textTheme.headline5?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'Create and share your brand with 100M user across the world',
                        style: textTheme.subtitle1,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.8,
                  child: PrimaryButton(
                    label: 'Sign in with Google',
                    icon: FontAwesomeIcons.google,
                    background: colorScheme.error,
                    foreground: Colors.white,
                    onTap: () {
                      /// perform google auth
                    },
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: width * 0.8,
                  child: PrimaryButton(
                    label: 'Continue with Twitter',
                    icon: FontAwesomeIcons.twitter,
                    background: Colors.blue,
                    foreground: Colors.white,
                    onTap: () {
                      /// perform twitter auth
                    },
                  ),
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () => null,
                  child: Text(
                    'Terms & conditions',
                    style: textTheme.button,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
