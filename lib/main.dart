import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _selectedUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Navigator(
        pages: [
          MaterialPage(
            child: UsersView(
              didSelector: (user) {
                setState(() {
                  _selectedUser = user;
                });
              },
            ),
          ),
          if (_selectedUser != null)
            MaterialPage(
              key: UserDetailView.valueKey,
              child: UserDetailView(
                user: _selectedUser!,
              ),
            )
        ],
        onPopPage: (route, result) {
          final page = route.settings as MaterialPage;
          if (page.key == UserDetailView.valueKey) {
            _selectedUser = null;
          }
          return route.didPop(result);
        },
      ),
    );
  }
}

class UsersView extends StatelessWidget {
  final _users = ["Kyle", "Andriana", "Andrew"];

  final ValueChanged didSelector;

  UsersView({Key? key, required this.didSelector}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: ListView.builder(
          itemCount: _users.length,
          itemBuilder: (context, index) {
            final user = _users[index];
            return Card(
              child: ListTile(
                title: Text(user),
                onTap: () => didSelector(user),
              ),
            );
          }),
    );
  }
}

class UserDetailView extends StatelessWidget {
  static const valueKey = ValueKey('UserDetailView');
  final String user;

  const UserDetailView({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),
      ),
      body: Center(
        child: Text('Hello, $user'),
      ),
    );
  }
}
