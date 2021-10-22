part of '../home.dart';

/// shows home UI
class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final _categories = const [
    DashboardCardItem(
      category: 'Reviews',
      icon: Icons.home_filled,
      categoryAbbrev: 'RVS',
      value: 1298,
      difference: 12.89,
      background: Color(0xffE3F6FD),
      foreground: Color(0xff000000),
    ),
    DashboardCardItem(
      category: 'Audience',
      icon: Icons.home_filled,
      categoryAbbrev: 'AUD',
      value: 12900,
      difference: -9.23,
      background: Color(0xffE8DCF8),
      foreground: Color(0xff000000),
    ),
    DashboardCardItem(
      category: 'Popularity',
      icon: Entypo.users,
      categoryAbbrev: 'POP',
      value: 3.5,
      difference: 19.45,
      background: Color(0xffF1F1F1),
      foreground: Color(0xff000000),
    ),
    DashboardCardItem(
      category: 'My Wallet',
      icon: FontAwesome5.wallet,
      categoryAbbrev: 'WAL',
      value: 12398,
      difference: -42.87,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    /// dimensions of the current display
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    /// app theme
    var appTheme = Theme.of(context);

    /// text theme of the application
    var textTheme = Theme.of(context).textTheme;

    /// color scheme of the application
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) =>
                  DashboardCard(item: _categories[index]),
              itemCount: _categories.length,
            ),
          ),
        ],
      ),
    );
  }
}
