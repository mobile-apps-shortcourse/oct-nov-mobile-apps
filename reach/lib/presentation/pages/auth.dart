import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:reach/config/extensions.dart';
import 'package:reach/config/themes.dart';
import 'package:reach/presentation/widgets/buttons.dart';
import 'package:twitter_login/twitter_login.dart';

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
            SizedBox(
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
            PrimaryButton(
              label: 'Sign in with Google',
              icon: FontAwesomeIcons.google,
              outline: true,
              onTap: () async {
                // google sign in
                GoogleSignIn _googleSignIn = GoogleSignIn();

                /// invoke google sign in
                var account = await _googleSignIn.signIn();

                if (account == null) {
                  context.showSnackBar('Sign in failed');
                } else {
                  context.showSnackBar('Signed in as ${account.displayName}');

                  /// obtain the authentication details of the logged in user
                  var authentication = await account.authentication;

                  /// create a sign in provider for firebase using google
                  var googleCredential = GoogleAuthProvider.credential(
                    idToken: authentication.idToken,
                    accessToken: authentication.accessToken,
                  );

                  /// firebase authentication
                  var auth = FirebaseAuth.instance;
                  var userCredential =
                      await auth.signInWithCredential(googleCredential);
                  var username = userCredential.user?.displayName;
                  var email = userCredential.user?.email;
                  var uid = userCredential.user?.uid;

                  context.showSnackBar('Signed in on firebase with id $uid');
                }
              },
            ),

            const SizedBox(height: 16),

            /// button
            // MaterialButton(
            //   onPressed: () {},
            //   child: Text("Sign in with Twitter"),
            // ),
            PrimaryButton(
              label: 'Sign in with Twitter',
              icon: FontAwesomeIcons.twitter,
              background: Colors.blue,
              foreground: Colors.white,
              onTap: () async {
                final twitterLogin = TwitterLogin(
                  // Consumer API keys
                  apiKey: 'aMSQJ2pKHYVborAGo0w72Y2CY',
                  // Consumer API Secret keys
                  apiSecretKey:
                      '5NjxvhwsSCqHxCWOKCr7j833rwR6oyOGeANVYzyYhg16GBC3LX',
                  // Registered Callback URLs in TwitterApp
                  // Android is a deeplink
                  // iOS is a URLScheme
                  redirectURI: 'https://reach-twitter-auth',
                );
                final authResult = await twitterLogin.login();
                switch (authResult.status) {
                  case TwitterLoginStatus.loggedIn:
                    // success
                    context
                        .showSnackBar('Signed in as ${authResult.user?.email}');

                    /// get credentials
                    var twitterCredential = TwitterAuthProvider.credential(
                      accessToken: authResult.authToken!,
                      secret: authResult.authTokenSecret!,
                    );

                    /// firebase authentication
                    var auth = FirebaseAuth.instance;
                    var userCredential =
                        await auth.signInWithCredential(twitterCredential);
                    var username = userCredential.user?.displayName;
                    var email = userCredential.user?.email;
                    var uid = userCredential.user?.uid;

                    context.showSnackBar('Signed in on firebase with id $uid');

                    break;
                  case TwitterLoginStatus.cancelledByUser:
                    // cancel
                    context.showSnackBar('Cancelled');
                    break;
                  case TwitterLoginStatus.error:
                    // error
                    context.showSnackBar('Error');
                    break;

                  default:
                    // if no cases above are met, then do something else
                    break;
                }
              },
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
