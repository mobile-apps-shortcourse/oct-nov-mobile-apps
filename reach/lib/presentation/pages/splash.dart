import 'package:flutter/material.dart';
import 'package:reach/config/constants.dart';
import 'package:reach/config/themes.dart';
import 'package:reach/presentation/widgets/buttons.dart';

/// splash page -> this is the first page any user sees when the application
/// is first launched.
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    /// set system UI overlays when the application is rendered
    /// to the user's display.
    kApplySystemOverlay(context);

    /// dimensions of the current display
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    /// text theme of the application
    var textTheme = Theme.of(context).textTheme;

    /// color scheme of the application
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
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
                      color: colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: const EdgeInsets.only(left: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Text(
                      'Pro',
                      style: textTheme.button?.copyWith(
                        color: colorScheme.background,
                      ),
                    ),
                  ),
                ],
              ),

              /// for adding space
              // SizedBox(height: 40,),

              /// text
              Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  left: 32,
                  right: 32,
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
                  /// todo -> navigate to the login / home page
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
