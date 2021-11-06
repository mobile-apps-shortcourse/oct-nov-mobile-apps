part of '../home.dart';

/// analytics wrapper class
class Analytics {
  final String title;
  final double totalValue;
  final double currentValue;
  final Function() onTap;

  Analytics({
    required this.title,
    required this.totalValue,
    required this.currentValue,
    required this.onTap,
  });

  String get percentage =>
      ((currentValue / totalValue) * 100).toStringAsPrecision(2);
}

/// home page for brand owners
class BrandDashboard extends StatefulWidget {
  const BrandDashboard({Key? key}) : super(key: key);

  @override
  _BrandDashboardState createState() => _BrandDashboardState();
}

class _BrandDashboardState extends State<BrandDashboard> {
  final _analytics = <Analytics>[
    Analytics(
      title: 'Subscriptions',
      totalValue: 12000,
      currentValue: 4500,
      onTap: () => null,
    ),
    Analytics(
      title: 'Campaigns',
      totalValue: 56035,
      currentValue: 37484,
      onTap: () => null,
    ),
    Analytics(
      title: 'Ratings & Reviews',
      totalValue: 120000,
      currentValue: 110000,
      onTap: () => null,
    ),
    Analytics(
      title: 'Earnings',
      totalValue: 4575,
      currentValue: 3843,
      onTap: () => null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    /// dimensions of the current display
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var kTheme = Theme.of(context);

    /// text theme of the application
    var textTheme = kTheme.textTheme;

    /// color scheme of the application
    var colorScheme = kTheme.colorScheme;

    return Column(
      children: [
        /// search
        GestureDetector(
          onTap: () {
            context.showSnackBar('Not done yet');

            /// todo -> show search UI
          },
          child: Container(
            width: width,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
            margin: const EdgeInsets.fromLTRB(24, 20, 24, 40),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.search),
                const SizedBox(width: 12),
                const Expanded(child: Text('Search an influencer')),
                IconButton(
                  icon: const Icon(Icons.filter_alt),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),

        /// analytics
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          height: height * 0.4,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              mainAxisExtent: height * 0.2 - 6,
            ),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                context.showSnackBar('Not implemented');

                /// todo -> show card details
              },
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _analytics[index].title,
                      style: textTheme.button
                          ?.copyWith(color: colorScheme.onSurface),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_analytics[index].percentage}%',
                            style: textTheme.headline4,
                          ),
                          Text(
                            '\$ ${_analytics[index].currentValue}',
                            style: textTheme.caption,
                          ),
                        ],
                      ),
                    )),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Learn more', style: textTheme.caption),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_right_alt)
                      ],
                    ),
                  ],
                ),
              ),
            ),
            itemCount: _analytics.length,
          ),
        ),

        /// influencers header
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          alignment: Alignment.centerLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Influencers',
                  style: textTheme.headline6,
                  textAlign: TextAlign.start,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'See more',
                    style: textTheme.button
                        ?.copyWith(color: colorScheme.onBackground),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_right_alt),
                ],
              ),
            ],
          ),
        ),

        /// influencers list
        Flexible(
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemBuilder: (context, index) => Container(
              width: 200,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 8,
                    left: 8,
                    right: 8,
                    child: Row(
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          width: 48,
                          height: 48,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: colorScheme.background,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Denver Bilson',
                                style: textTheme.subtitle1,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '22K+ audiences',
                                style: textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            separatorBuilder: (context, _) => const SizedBox(width: 8),
            itemCount: 5,
          ),
        ),
      ],
    );
  }
}
