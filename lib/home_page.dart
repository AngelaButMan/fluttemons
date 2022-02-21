import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttemons/my_appbar_page.dart';
import 'package:flutter/material.dart';
import 'widgets/login_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.cyan,
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return MyAppBar();
            } else if (snapshot.hasError) {
              return Center(child: Text('Error'));
            } else {
              return LoginWidget();
            }
          },
        ),
      );
}
