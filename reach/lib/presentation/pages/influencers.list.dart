part of 'home.dart';

/// list of influencers registered on the platform
class InfluencersList extends StatefulWidget {
  const InfluencersList({Key? key}) : super(key: key);

  @override
  _InfluencersListState createState() => _InfluencersListState();
}

class _InfluencersListState extends State<InfluencersList> {
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'All registered Influencers',
              style: textTheme.headline6,
            ),
          ),

          // building the list of influencers to span across the remainder
          // of the column hence wrapping the listview with an expanded widget
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemBuilder: (context, index) => InfluencerListTile(
                influencer: UserAccount(
                  createdOn: 1,
                  email: 'q@mail.com',
                  id: '233',
                  lastLoginDate: 1,
                  username: 'Denver Bilson',
                  avatar: '',
                  userType: UserType.influencer,
                ),
                onTap: () {
                  context
                      .showSnackBar('You have tapped on the influencer card');
                },
              ),
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
