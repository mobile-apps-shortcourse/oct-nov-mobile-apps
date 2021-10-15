import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:reach/config/dependency.injection.dart';
import 'package:reach/config/themes.dart';
import 'package:reach/presentation/blocs/auth_cubit.dart';
import 'package:reach/presentation/pages/home.dart';
import 'package:reach/presentation/widgets/buttons.dart';

/// authentication page.
/// handles login & registration
class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final _authBloc = AuthCubit(repository: authRepository);
  bool _loading = false;

  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }

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

    return BlocListener<AuthCubit, AuthState>(
      bloc: _authBloc,
      listener: (context, state) {
        if (mounted) setState(() => _loading = state is AuthLoading);

        /// show error message if process fails
        if (state is AuthError && mounted) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                // behavior: SnackBarBehavior.floating,
                content: Text(
                  state.reason,
                  style:
                      textTheme.button?.copyWith(color: colorScheme.background),
                ),
                backgroundColor: colorScheme.primaryVariant,
              ),
            );
        }

        /// navigate to home page when logged in
        if (state is AuthSuccess) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
              (route) => false);
        }
      },
      child: Scaffold(
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
                        SizedBox(
                          width: width,
                          height: height * 0.4,
                          child: LottieBuilder.asset(
                              'assets/users_profile_cards.json'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16, top: 24),
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
                  if (_loading) ...{
                    const Center(child: CircularProgressIndicator.adaptive()),
                  } else ...[
                    SizedBox(
                      width: width * 0.7,
                      child: PrimaryButton(
                        label: 'Sign in with Google',
                        icon: FontAwesomeIcons.google,
                        background: colorScheme.primaryVariant,
                        foreground: colorScheme.primaryVariant,
                        outlined: true,
                        onTap: () async {
                          /// perform google auth
                          await _authBloc.googleSignIn();
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: width * 0.7,
                      child: PrimaryButton(
                        label: 'Continue with Twitter',
                        icon: FontAwesomeIcons.twitter,
                        background: Colors.blue,
                        foreground: Colors.white,
                        onTap: () async {
                          /// perform twitter auth
                          await _authBloc.twitterSignIn();
                        },
                      ),
                    ),
                  ],
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
      ),
    );
  }
}
