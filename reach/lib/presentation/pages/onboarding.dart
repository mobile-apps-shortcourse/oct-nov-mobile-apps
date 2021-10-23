import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reach/config/constants.dart';
import 'package:reach/config/themes.dart';
import 'package:reach/presentation/pages/auth.dart';
import 'package:reach/presentation/widgets/buttons.dart';
import 'package:reach/presentation/widgets/custom.shapes.dart';

/// onboarding process for new users
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    /// text theme of the application
    var textTheme = Theme.of(context).textTheme;

    /// color scheme of the application
    var colorScheme = Theme.of(context).colorScheme;

    /// set system UI overlays when the application is rendered
    /// to the user's display.
    kApplySystemOverlay(
      context,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          _currentPageIndex == 1 ? Brightness.dark : Brightness.light,
    );

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              onPageChanged: (pageIndex) =>
                  setState(() => _currentPageIndex = pageIndex),
              children: [
                /// 1. influencer
                OnboardingItemPage(
                  item: OnboardingItem(
                    imageUrl: kInfluencerImageUrl,
                    title: 'Influencer',
                    subtitle:
                        'Make a brand known to your 11+ billion audience and make money instantly',
                  ),
                ),

                /// 2. brand
                OnboardingItemPage(
                  item: OnboardingItem(
                    imageUrl: kBrandImageUrl,
                    title: 'Brand',
                    subtitle:
                        'Get your multi-million brand out there to the general public through prominent influencers',
                  ),
                ),

                /// 3. audience
                OnboardingItemPage(
                  item: OnboardingItem(
                    imageUrl: kAudienceImageUrl,
                    title: 'Audience',
                    subtitle:
                        'Get to know your dream brands though your favorite influencers',
                  ),
                ),
              ],
            ),
          ),
          if (_currentPageIndex == 2) ...{
            /// get started
            Positioned(
              left: 0,
              right: 16,
              bottom: 16,
              child: Align(
                alignment: Alignment.centerRight,
                child: PrimaryButton(
                  label: 'Get started',
                  icon: Icons.arrow_right_alt,
                  onTap: () {
                    /// navigate to the login page
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AuthenticationPage()),
                      (_) => false,
                    );
                  },
                ),
              ),
            ),
          } else ...[
            /// skip
            Positioned(
              bottom: 16,
              left: 16,
              child: TextButton(
                onPressed: () {
                  /// skip to the login page
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AuthenticationPage()),
                    (_) => false,
                  );
                },
                child: Text(
                  'Skip',
                  style:
                      textTheme.button?.copyWith(color: colorScheme.onPrimary),
                ),
              ),
            ),

            /// next
            Positioned(
              bottom: 16,
              right: 16,
              child: TextButton(
                onPressed: () {
                  ///  move to the next page
                  _pageController.animateToPage(
                    ((_pageController.page ?? 0) + 1).toInt(),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Row(
                  children: [
                    Text(
                      'Next',
                      style: textTheme.button
                          ?.copyWith(color: colorScheme.onPrimary),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_right_alt_outlined,
                      color: colorScheme.onPrimary,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// onboarding page
class OnboardingItem {
  final String imageUrl;
  final String title;
  final String subtitle;

  OnboardingItem({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });
}

class OnboardingItemPage extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingItemPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// dimensions of the current display
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    /// text theme of the application
    var textTheme = Theme.of(context).textTheme;

    /// color scheme of the application
    var colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        /// bottom
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: height * 0.35,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.title,
                  style: textTheme.headline4,
                ),
                const SizedBox(height: 12),
                Text(
                  item.subtitle,
                  style: textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),

        /// top overlay
        Positioned.fill(
          bottom: height * 0.25,
          child: ClipPath(
            clipper: RoundedBottomShape(),
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.primary,
              ),
              child: CachedNetworkImage(
                imageUrl: item.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
