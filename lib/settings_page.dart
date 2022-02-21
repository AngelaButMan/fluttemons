import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:provider/provider.dart';
import 'datastrore/pokemon_local_store.dart';
import 'provider/auth_provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  showSnackBar(String message) {
    final snackBar =
        SnackBar(content: Text(message), duration: Duration(seconds: 3));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
        body: SafeArea(
      child: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Container(
            margin: EdgeInsets.only(left: 15, right: 10),
            child: Row(
              // alignment: WrapAlignment.start,
              // spacing: 5,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Logged in as: \n${user.displayName!}',
                  style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                //SizedBox(width: 15),
                CircleAvatar(
                  radius: 52,
                  backgroundColor: Colors.cyan,
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(user.photoURL!)),
                ),
              ],
            ),
          ),
          new Padding(
            padding: EdgeInsets.zero,
            child: new Divider(),
          ),
          //SizedBox(height: 15),
          SimpleSettingsTile(
              title: "Clear cache",
              subtitle: '',
              leading: Icon(
                Icons.remove_circle_outline,
                color: Colors.cyan,
              ),
              onTap: () {
                showSnackBar('Cache cleared');
                DefaultCacheManager().emptyCache();
                imageCache!.clear();
                imageCache!.clearLiveImages();
              }),
          SimpleSettingsTile(
              title: "Clear local strorage",
              subtitle: '',
              leading: Icon(Icons.remove_circle, color: Colors.cyan),
              onTap: () {
                showSnackBar('Local storage cleared');
                PokemonLocalStore.clear();
              }),
          SimpleSettingsTile(
              title: "Logout",
              subtitle: '',
              leading: Icon(Icons.logout_outlined, color: Colors.cyan),
              onTap: () {
                showSnackBar('User logout');
                final provider =
                    Provider.of<SignInProvider>(context, listen: false);
                provider.logout();
              }),
        ],
      ),
    ));
  }
}
