import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:reach/config/constants.dart';
import 'package:reach/config/extensions.dart';
import 'package:reach/config/themes.dart';
import 'package:reach/presentation/blocs/auth_cubit.dart';
import 'package:reach/presentation/pages/account.picker.dart';
import 'package:reach/presentation/widgets/buttons.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

/// authentication page.
/// handles login & registration
class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    /// dimensions of the current display
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    /// app theme
    var appTheme = Theme.of(context);

    /// text theme of the application
    var textTheme = appTheme.textTheme;

    /// color scheme of the application
    var colorScheme = appTheme.colorScheme;

    /// set system UI overlays when the application is rendered
    /// to the user's display.
    bool isLightTheme = appTheme.brightness == Brightness.light;
    kApplySystemOverlay(
      context,
      statusBarIconBrightness:
          isLightTheme ? Brightness.dark : Brightness.light,
      systemNavigationBarIconBrightness:
          isLightTheme ? Brightness.dark : Brightness.light,
    );

    return BlocListener<AuthCubit, AuthState>(
      bloc: context.read<AuthCubit>(),
      listener: (context, state) {
        if (mounted) setState(() => _loading = state is AuthLoading);

        /// show error message if process fails
        if (state is AuthError && mounted) {
          context.showSnackBar(state.reason);
        }

        /// navigate to home page when logged in
        if (state is AuthSuccess) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const AccountPickerPage()),
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
                          await context.read<AuthCubit>().googleSignIn();
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
                          await context.read<AuthCubit>().twitterSignIn();
                        },
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: _showTermsAndConditionsSheet,
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

  void _showTermsAndConditionsSheet() async {
    /// dimensions of the current display
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    /// app theme
    var appTheme = Theme.of(context);

    /// text theme of the application
    var textTheme = appTheme.textTheme;

    /// color scheme of the application
    var colorScheme = appTheme.colorScheme;

    final result = await showSlidingBottomSheet(context,
        resizeToAvoidBottomInset: true, builder: (context) {
      return SlidingSheetDialog(
        elevation: 8,
        cornerRadius: 16,
        backdropColor: colorScheme.onBackground.withOpacity(0.2),
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [0.4, 0.7, 1.0],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        builder: (context, state) {
          return Container(
            color: colorScheme.background,
            height: height * 0.6,
            child: Center(
              child: Material(
                color: colorScheme.background,
                child: InkWell(
                  onTap: () => Navigator.pop(context, 'This is the result.'),
                  child: Padding(
                    padding: const EdgeInsets.all(16),

                    /// todo -> add terms & conditions
                    child: Text(
                      kFeatureUnderDev,
                      style: textTheme.bodyText1,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });

    print(result); // This is the result.
  }
}
