part of '../home.page.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;
    var textTheme = theme.textTheme;

    return Center(
      child: Column(
        children: [
          const Icon(Icons.search, size: 96,),
          Text('Search', style: textTheme.headline5,),
        ],
      ),
    );
  }
}
