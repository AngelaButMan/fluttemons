import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Image.asset('assets/images/pokeball_logo1.png',
              height: 150, width: 150),
          //Spacer(),
          SizedBox(height: 25),
          Align(
            alignment: Alignment.center,
            child: BorderedText(
              strokeWidth: 3,
              strokeColor: Colors.black,
              child: Text(
                'Welcome to the Fluttemons!',
                style: TextStyle(
                    fontSize: 23,
                    //decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Spacer(),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                minimumSize: Size(double.infinity, 50)),
            icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
            label: Text('Sign Up with Google'),
            onPressed: () {
              final provider =
                  Provider.of<SignInProvider>(context, listen: false);
              provider.googleLogin();
            },
          )
        ],
      ),
    );
  }
}
