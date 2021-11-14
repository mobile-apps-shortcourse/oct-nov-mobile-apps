part of '../home.page.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool _expandedChannels = true, _expandedMessages = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var deviceWidth = size.width;
    var deviceHeight = size.height;

    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;
    var textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          // search bar
          _buildSearchBar(deviceWidth, colorScheme, textTheme),

          Divider(color: colorScheme.onBackground.withOpacity(0.2), height: 24),

          // channels
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Channels',
                          style: textTheme.caption?.copyWith(
                            color: colorScheme.onBackground,
                          )),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => setState(
                            () => _expandedChannels = !_expandedChannels),
                        icon: Icon(_expandedChannels
                            ? Icons.expand_less
                            : Icons.expand_more),
                      ),
                    ],
                  ),
                ),

                /// actual channels
                if (_expandedChannels) ...[
                  ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemBuilder: (context, index) => Row(
                      children: [
                        Text(
                          '#',
                          style: textTheme.headline6,
                        ),
                        const SizedBox(width: 16),
                        Text(sampleChannels[index]),
                      ],
                    ),

                    /// creates a spacing between the child
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemCount: sampleChannels.length,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, top: 40),
                    child: GestureDetector(
                      onTap: () => showSnackBar(context, 'Add a new channel'),
                      child: Row(
                        children: [
                          Text(
                            '+',
                            style: textTheme.headline6,
                          ),
                          const SizedBox(width: 16),
                          const Text('Add Channel'),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          Divider(color: colorScheme.onBackground.withOpacity(0.2), height: 24),

          // direct messages
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Direct Messages',
                          style: textTheme.caption?.copyWith(
                            color: colorScheme.onBackground,
                          )),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => setState(
                            () => _expandedMessages = !_expandedMessages),
                        icon: Icon(_expandedMessages
                            ? Icons.expand_less
                            : Icons.expand_more),
                      ),
                    ],
                  ),
                ),
                if (_expandedMessages) ...[
                  ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemBuilder: (context, index) => Row(
                      children: [
                        /// avatar
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 28,
                              width: 28,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: colorScheme.surface,
                              ),
                              child: Image.network(
                                sampleUsers[index].avatar,
                                fit: BoxFit.cover,
                              ),
                            ),

                            /// online indicator
                            if (sampleUsers[index].online) ...{
                              Positioned(
                                bottom: -4,
                                right: -4,
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: colorScheme.background,
                                      width: 3,
                                    ),
                                  ),
                                ),
                              ),
                            },
                          ],
                        ),

                        /// username
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(sampleUsers[index].username),
                        )
                      ],
                    ),

                    /// creates a spacing between the child
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemCount: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, top: 40),
                    child: GestureDetector(
                      onTap: () => showSnackBar(context, 'Add a new channel'),
                      child: Row(
                        children: [
                          Text(
                            '+',
                            style: textTheme.headline6,
                          ),
                          const SizedBox(width: 16),
                          const Text('Invite people'),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// function that returns a widget of type container
  Widget _buildSearchBar(
          double width, ColorScheme colorScheme, TextTheme textTheme) =>
      GestureDetector(
        onTap: () => showSnackBar(context, 'Search not implemented'),
        child: Container(
          width: width,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: colorScheme.background,
            border: Border.all(
              color: colorScheme.onBackground.withOpacity(0.1),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Jump to...',
            style: textTheme.subtitle1?.copyWith(
              color: colorScheme.onBackground.withOpacity(0.5),
            ),
          ),
        ),
      );
}
