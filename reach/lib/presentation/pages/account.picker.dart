import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reach/bloc/user_cubit.dart';
import 'package:reach/config/constants.dart';
import 'package:reach/config/injector.dart';
import 'package:reach/config/themes.dart';
import 'package:reach/model/user.dart';
import 'package:reach/presentation/pages/home.dart';
import 'package:reach/presentation/widgets/buttons.dart';
import 'package:reach/config/extensions.dart';

/// account type wrapper.
/// used to create te account type picker widget
class AccountType {
  final UserType type;
  final String imageUrl;

  AccountType({required this.type, required this.imageUrl});
}

/// user picks account type
class AccountPickerPage extends StatefulWidget {
  const AccountPickerPage({Key? key}) : super(key: key);

  @override
  _AccountPickerPageState createState() => _AccountPickerPageState();
}

class _AccountPickerPageState extends State<AccountPickerPage> {
  final _userCubit = UserCubit(repository: Injector.get());

  bool _loading = false;
  UserType _selectedUserType = UserType.unknown;
  final _userTypes = <AccountType>[
    AccountType(
      type: UserType.influencer,
      imageUrl: kInfluencerImgUrl,
    ),
    AccountType(
      type: UserType.brand,
      imageUrl: kBrandImgUrl,
    ),
    AccountType(
      type: UserType.audience,
      imageUrl: kAudienceImgUrl,
    ),
  ];

  @override
  void dispose() {
    _userCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var kTheme = Theme.of(context);

    /// text theme of the application
    var textTheme = kTheme.textTheme;

    /// color scheme of the application
    var colorScheme = kTheme.colorScheme;

    kApplySystemOverlay(
      context,
      statusBarColor: colorScheme.background,
    );

    return BlocListener(
      bloc: _userCubit,
      listener: (context, state) {
        if (mounted) setState(() => _loading = state is UserLoading);
        if (state is UserSuccess && mounted) {
          context.showSnackBar('User updated successfully');
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
              (route) => false);
        }

        if (state is UserError && mounted) {
          context.showSnackBar(state.reason);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: width,
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Continue as...', style: textTheme.headline4),
                const SizedBox(height: 8),
                Text('Select an account type to get started',
                    style: textTheme.subtitle1),

                const SizedBox(height: 40),

                // grid of user account cards
                Expanded(
                  child: AccountPickerCard(
                    accountTypes: _userTypes,
                    active: _selectedUserType,
                    onSelected: (selected) =>
                        setState(() => _selectedUserType = selected.type),
                  ),
                ),

                // proceed
                Align(
                  alignment: Alignment.center,
                  child: _loading
                      ? const CircularProgressIndicator.adaptive()
                      : PrimaryButton(
                          label: 'Save & Continue',
                          icon: Icons.arrow_right_alt,
                          onTap: () => _userCubit.updateUser(
                              userType: _selectedUserType),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AccountPickerCard extends StatelessWidget {
  final List<AccountType> accountTypes;
  final Function(AccountType) onSelected;
  final UserType active;

  const AccountPickerCard({
    Key? key,
    required this.accountTypes,
    required this.active,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var kTheme = Theme.of(context);

    /// color scheme of the application
    var colorScheme = kTheme.colorScheme;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
      ),
      itemBuilder: (context, index) {
        var accountType = accountTypes[index];
        var selected = active == accountType.type;

        return GestureDetector(
          onTap: () {
            onSelected(accountType);
          },
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Stack(
              children: [
                /// image
                Positioned.fill(
                    child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    colorScheme.onBackground,
                    selected
                        ? kTheme.brightness == Brightness.dark
                            ? BlendMode.darken
                            : BlendMode.lighten
                        : BlendMode.saturation,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: accountType.imageUrl,
                    fit: BoxFit.cover,
                  ),
                )),

                /// check mark
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 150),
                  top: selected ? 6 : -40,
                  right: 8,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.done,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),

                /// label
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surface.withOpacity(0.8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      accountType.type.name,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: accountTypes.length,
    );
  }
}
