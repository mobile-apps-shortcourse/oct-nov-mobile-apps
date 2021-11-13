part of '../home.page.dart';

class DMTab extends StatefulWidget {
  const DMTab({Key? key}) : super(key: key);

  @override
  _DMTabState createState() => _DMTabState();
}

class _DMTabState extends State<DMTab> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;
    var textTheme = theme.textTheme;

    return Center(
      child: Column(
        children: [
          const Icon(Icons.question_answer, size: 96,),
          Text('DMs', style: textTheme.headline5,),
        ],
      ),
    );
  }
}

