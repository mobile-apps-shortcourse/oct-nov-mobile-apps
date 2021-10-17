import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reach/config/constants.dart';
import 'package:reach/config/extensions.dart';
import 'package:reach/config/themes.dart';
import 'package:reach/presentation/blocs/auth_cubit.dart';
import 'package:reach/presentation/pages/home.dart';
import 'package:reach/presentation/pages/onboarding.dart';
import 'package:reach/presentation/widgets/buttons.dart';

/// splash page -> this is the first page any user sees when the application
/// is first launched.
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _loggedIn = false;

  @override
  void initState() {
    super.initState();
    doAfterDelay(() => context.read<AuthCubit>().getCurrentUser());
  }

  @override
  Widget build(BuildContext context) {
    var appTheme = Theme.of(context);

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

    /// text theme of the application
    var textTheme = appTheme.textTheme;

    /// color scheme of the application
    var colorScheme = appTheme.colorScheme;

    /// dimensions of the current display
    var width = MediaQuery.of(context).size.width;

    return BlocListener<AuthCubit, AuthState>(
      bloc: context.read<AuthCubit>(),
      listener: (context, state) {
        logger.e(state.runtimeType);
        if (mounted) setState(() => _loggedIn = state is AuthSuccess);
      },
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      applicationName,
                      style: textTheme.headline3,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.onSecondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      child: Text(
                        'Pro',
                        style: textTheme.button
                            ?.copyWith(color: colorScheme.secondaryVariant),
                      ),
                    ),
                  ],
                ),

                /// text
                Padding(
                  padding: EdgeInsets.only(
                    top: 40,
                    left: width * 0.1,
                    right: width * 0.1,
                  ),
                  child: Text(
                    applicationSlogan,
                    style: textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

            /// button
            Positioned(
              left: 0,
              right: 0,
              bottom: 24,
              child: Center(
                child: PrimaryButton(
                  label: 'Explore',
                  icon: Icons.arrow_right_alt,
                  onTap: () {
                    // navigate to the onboarding page
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => _loggedIn
                              ? const HomePage()
                              : const OnboardingPage()),
                      (_) => false,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
