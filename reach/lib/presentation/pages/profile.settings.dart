part of 'home.dart';

/// user profile settings page
class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  _ProfileStateSettings createState() => _ProfileStateSettings();
}

class _ProfileStateSettings extends State<ProfileSettings> {
  @override
  Widget build(BuildContext context) {
    /// dimensions of the current display
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var kTheme = Theme.of(context);

    /// color scheme of the application
    var colorScheme = kTheme.colorScheme;
    var textTheme = kTheme.textTheme;

    return SizedBox(
        width: width,
        child: Column(
          children: [],
        ));
  }
}
