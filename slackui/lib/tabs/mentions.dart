part of '../home.page.dart';

class MentionsTab extends StatefulWidget {
  const MentionsTab({Key? key}) : super(key: key);

  @override
  _MentionsTabState createState() => _MentionsTabState();
}

class _MentionsTabState extends State<MentionsTab> {
  @override
  Widget build(BuildContext context) =>
      _buildTemplateUI(context, Icons.alternate_email, 'Mentions');
}
