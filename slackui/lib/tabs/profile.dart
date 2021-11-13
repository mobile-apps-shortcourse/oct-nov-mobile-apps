part of '../home.page.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;
    var textTheme = theme.textTheme;

    return Center(
      child: Column(
        children: [
          const Icon(Icons.person, size: 96,),
          Text('Profile', style: textTheme.headline5,),
        ],
      ),
    );
  }
}
