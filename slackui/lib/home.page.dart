import 'package:flutter/material.dart';
import 'package:slackui/sample.dataset.dart';

part 'tabs/dms.dart';

/// parts of this part
part 'tabs/home.dart';

part 'tabs/mentions.dart';

part 'tabs/profile.dart';

part 'tabs/search.dart';

/// first page to display when the user launches the application
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;
    var textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: colorScheme.onPrimary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'U',
                style: textTheme.headline6?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
            const Text('UG Short Course'),
          ],
        ),
      ),
      body: _currentIndex == 0
          ? const HomeTab()
          : _currentIndex == 1
              ? const DMTab()
              : _currentIndex == 2
                  ? const MentionsTab()
                  : _currentIndex == 3
                      ? const SearchTab()
                      : const ProfileTab(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.drive_file_rename_outline),
        onPressed: () {
          // todo -> edit something
          print('Hello');
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        onTap: (int index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: 'DMs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alternate_email),
            label: 'Mentions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'You',
          ),
        ],
      ),
    );
  }
}

void showSnackBar(BuildContext context, String message) =>
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
