import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:reach/bloc/authentication_cubit.dart';
import 'package:reach/config/extensions.dart';
import 'package:reach/config/injector.dart';
import 'package:reach/config/themes.dart';
import 'package:reach/presentation/pages/account.picker.dart';
import 'package:reach/presentation/widgets/buttons.dart';
import 'package:reach/repository/auth.repository.dart';

/// allows for user authentication using google & twitter.
/// it uses the auth bloc to achieve this purpose.
class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  /// bloc
  final _authCubit = AuthenticationCubit(repository: Injector.get());

  bool _loading = false;

  @override
  void dispose() {
    _authCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// dimensions of the current display
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var kTheme = Theme.of(context);

    /// text theme of the application
    var textTheme = kTheme.textTheme;

    /// color scheme of the application
    var colorScheme = kTheme.colorScheme;

    /// set system UI overlays when the application is rendered
    /// to the user's display.
    kApplySystemOverlay(
      context,
      statusBarColor: colorScheme.background,
      statusBarIconBrightness: kTheme.brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
      systemNavigationBarIconBrightness: kTheme.brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
    );

    return Scaffold(
      body: SizedBox.expand(
        child: BlocListener(
          bloc: _authCubit,
          listener: (context, state) {
            if (state is AuthenticationSuccess) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const AccountPickerPage()),
                (route) => false,
              );
            }

            if (state is AuthenticationError) {
              context.showSnackBar(state.reason);
            }

            /// update the UI of a stateful widget
            setState(() => _loading = state is AuthenticationLoading);
          },
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

              if (_loading) ...{
                Center(
                    child: CircularProgressIndicator.adaptive(
                  valueColor:
                      AlwaysStoppedAnimation(colorScheme.primaryVariant),
                )),
              } else ...[
                /// google sign-in button
                PrimaryButton(
                  label: 'Sign in with Google',
                  icon: FontAwesomeIcons.google,
                  outline: true,
                  onTap: () => _authCubit.signInWithProvider(
                      provider: SignInProvider.google),
                ),

                const SizedBox(height: 16),

                /// twitter sign-in button
                PrimaryButton(
                  label: 'Sign in with Twitter',
                  icon: FontAwesomeIcons.twitter,
                  background: Colors.blue,
                  foreground: Colors.white,
                  onTap: () => _authCubit.signInWithProvider(
                      provider: SignInProvider.twitter),
                ),
              ],

              const SizedBox(height: 24),

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
      ),
    );
  }
}
