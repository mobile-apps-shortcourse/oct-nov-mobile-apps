part of '../home.page.dart';

class MentionsTab extends StatefulWidget {
  const MentionsTab({Key? key}) : super(key: key);

  @override
  _MentionsTabState createState() => _MentionsTabState();
}

class _MentionsTabState extends State<MentionsTab> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;
    var textTheme = theme.textTheme;

    return Center(
      child: Column(
        children: [
          const Icon(
            Icons.alternate_email,
            size: 96,
          ),
          Text(
            'Mentions',
            style: textTheme.headline5,
          ),
        ],
      ),
    );
  }
}
