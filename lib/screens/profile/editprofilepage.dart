import 'package:flutter/material.dart';
import "package:gameaiupdate/models/profileuser.dart";
import "package:gameaiupdate/screens/profile/userpreferences.dart";
import "package:gameaiupdate/screens/profile/profileappbar.dart";
import "package:gameaiupdate/screens/profile/profilewidget.dart";
import "package:gameaiupdate/screens/profile/textfieldwidget.dart";
import "package:gameaiupdate/screens/profile/profilepage.dart";
import "package:gameaiupdate/shared/loading.dart";
import "package:gameaiupdate/models/profileuser.dart";
import "package:gameaiupdate/services/auth.dart";
import "package:gameaiupdate/services/database.dart";

class EditProfilePage extends StatefulWidget {
  ProUser user;
  String name;
  String email;
  String about;
  EditProfilePage(ProUser user) {
    this.user = user;
    this.name = user.name;
    this.email = user.email;
    this.about = user.about;
  }
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  //ProUser user = UserPreferences().myUser;
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;
  bool isEditProfile = true;
  @override
  Widget build(BuildContext context) => loading
      ? Loading()
      : Scaffold(
          appBar: buildAppBar(context, isEditProfile, widget.user),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              physics: BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  isEdit: true,
                  imagePath: widget.user.imagePath,
                  onClicked: () async {},
                ),
                const SizedBox(height: 15),
                TextFieldWidget(
                  label: 'Full Name',
                  hint: 'සම්පූර්ණ නම',
                  invaliderror: 'සම්පූර්ණ නම ඇතුලත් කරන්න',
                  text: widget.user.name,
                  onChanged: (name_val) {
                    setState(() => widget.name = name_val);
                  },
                ),
                const SizedBox(height: 15),
                TextFieldWidget(
                  label: 'Email',
                  hint: 'විද්යුත් තැපැල් ලිපිනය',
                  invaliderror: 'ඊමේල් ලිපිනය ඇතුලත් කරන්න',
                  text: widget.user.email,
                  onChanged: (email_val) {
                    setState(() => widget.email = email_val);
                  },
                ),
                const SizedBox(height: 15),
                TextFieldWidget(
                  label: 'About',
                  hint: 'ඔබ ගැන සඳහන් කරන්න',
                  invaliderror: 'ඔබ ගැන තොරතුරු ඇතුළත් කිරීමට වග බලා ගන්න',
                  text: widget.user.about,
                  maxLines: 5,
                  onChanged: (about_val) {
                    setState(() => widget.about = about_val);
                  },
                ),
                SizedBox(height: 20.0),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: Colors.purple[600],
                      shape: StadiumBorder(),
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: Text(
                      'සුරකින්න',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() => loading = true);
                        print('validated');
                        //print(name);
                        dynamic currentUserId = await _auth.getCurrentUser();
                        dynamic result = await DatabaseService().updateUserProfileData(currentUserId.uid, widget.name, widget.email, widget.about);
                        print(currentUserId.uid);
                        print(result);
                        if (result == null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ProfilePage()),
                          );
                          setState(() => loading = false);
                        }
                      }
                    },
                  ),
                ),
              ],
            ), //ListView
          ),
        );
}
