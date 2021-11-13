/// user data model
class User {
  final String avatar;
  final String username;
  final bool online;

  const User({
    required this.avatar,
    required this.username,
    this.online = false,
  });
}

/// sample users
const sampleUsers = <User>[
  User(
    avatar:
        'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGhhbmRzb21lfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    username: 'Dennis Bilson (You)',
    online: true,
  ),
  User(
    avatar:
        'https://images.unsplash.com/photo-1482849737880-498de71dda8d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8aGFuZHNvbWV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    username: 'James Bedu-Addo',
  ),
];

/// sample channels
final sampleChannels = <String>['general', 'random', 'work'];
