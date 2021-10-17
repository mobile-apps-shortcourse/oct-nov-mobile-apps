import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reach/config/constants.dart';
import 'package:reach/data/entities/user.dart';
import 'package:reach/presentation/blocs/auth_cubit.dart';
import 'package:reach/presentation/pages/home.dart';
import 'package:reach/presentation/widgets/custom.shapes.dart';

class AccountPickerPage extends StatefulWidget {
  const AccountPickerPage({Key? key}) : super(key: key);

  @override
  _AccountPickerPageState createState() => _AccountPickerPageState();
}

class _AccountPickerPageState extends State<AccountPickerPage> {
  var _userType = UserType.brand;
  final _userAccountTypes = UserType.values
      .where((element) => element != UserType.none)
      .toList(growable: false);

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

    return BlocListener<AuthCubit, AuthState>(
      bloc: context.read<AuthCubit>(),
      listener: (context, state) {
        if (state is AuthSuccess) {
          logger.i('starting as -> ${_userType.name}');
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(24, 40, width * 0.3, 8),
                child: Text(
                  'Choose an account type',
                  style: textTheme.headline4
                      ?.copyWith(color: colorScheme.onBackground),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40, left: 24),
                child: Text(
                  'Select an account type to get started',
                  style: textTheme.subtitle1?.copyWith(
                      color: colorScheme.onBackground.withOpacity(0.67)),
                ),
              ),
              Expanded(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: height * 0.45,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: false,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    onPageChanged: (index, _) => setState(
                        () => _userType = _userAccountTypes.elementAt(index)),
                    scrollDirection: Axis.horizontal,
                  ),
                  items: _userAccountTypes
                      .map(
                        (type) => Container(
                          clipBehavior: Clip.antiAlias,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                bottom: 24,
                                child: ClipPath(
                                  clipper: RoundedBottomShape(),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: colorScheme.primary,
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: kOnboardingImageUrls[
                                          _userAccountTypes.indexOf(type)],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 16,
                                left: 0,
                                right: 0,
                                child: Text(
                                  type.name.toUpperCase(),
                                  style: textTheme.headline6,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await context.read<AuthCubit>().saveUserType(_userType);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
                (route) => false);
          },
          label: const Text('Proceed'),
          icon: const Icon(Icons.arrow_right_alt),
        ),
      ),
    );
  }
}
