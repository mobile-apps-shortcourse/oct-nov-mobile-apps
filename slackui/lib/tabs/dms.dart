part of '../home.page.dart';

class DMTab extends StatefulWidget {
  const DMTab({Key? key}) : super(key: key);

  @override
  _DMTabState createState() => _DMTabState();
}

class _DMTabState extends State<DMTab> {
  @override
  Widget build(BuildContext context) => _buildTemplateUI(context, Icons.question_answer, 'DMs');
}
