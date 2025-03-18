import 'package:flutter/material.dart';
import 'package:photo_pdf/pages/take_picture.dart';
import 'package:photo_pdf/widgets/block_raised_button.dart';
import 'package:photo_pdf/widgets/base/responsive_scaffold.dart';
// import 'package:photo_pdf/storage.dart';
import 'package:photo_pdf/constants.dart';
// import 'package:photo_pdf/screens/home.dart';
import 'package:photo_pdf/pages/signup.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  String username = '', password = '';
  bool loading = false;

  void goSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignupPage(),
      ),
    );
  }

  void goForgotPassword() {}

  void runSignin() async {
    // setState(() {
    //   loading = true;
    // });
    // Map res = await $post('/signin', {'name': username, 'password': password});
    // setState(() {
    //   loading = false;
    // });
    // if (res['status'] != 200) {
    //   return print(res['message']);
    // }
    // var data = res['data'];
    // var _user = data['logged_in_user'];
    // await AppStorage.setToken(data['token']);
    // await AppStorage.setUsername(_user['name']);
    // await AppStorage.setAvatar(_user['avatar']);

    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) =>
    //         (res['data']['admin'] != null && res['data']['admin'])
    //             ? AdminHomePage()
    //             : HomePage(),
    //   ),
    // );

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => TakePicturePage()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ResponsiveScaffold(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: Image(
              image: AssetImage('assets/images/sign_topbar.png'),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: appPadding * 2),
            padding: EdgeInsets.symmetric(horizontal: appPadding * 1.5),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 1,
                  ),
                ),
                Image(
                  image: AssetImage("assets/images/logo.png"),
                  height: size.height / 4,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: SizedBox(
                    height: 1,
                  ),
                ),
                Text(
                  'Hello, App Member',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: appPadding / 3,
                ),
                Text(
                  'Sign in to continue',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: appPadding,
                ),
                TextFormField(
                  initialValue: '',
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 14),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(appPadding / 2),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hoverColor: Colors.white,
                    focusColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(appPadding / 2),
                        borderSide: BorderSide(color: Colors.white)),
                    suffixIcon: Icon(
                      Icons.check_circle_outline_rounded,
                      color: Colors.white,
                    ),
                  ),
                  onChanged: (text) => setState(() {
                    username = text;
                  }),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: appPadding * 2 / 3,
                ),
                TextFormField(
                  initialValue: '',
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 14),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(appPadding / 2),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hoverColor: Colors.white,
                    focusColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(appPadding / 2),
                        borderSide: BorderSide(color: Colors.white)),
                    suffixIcon: Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.white,
                    ),
                  ),
                  onChanged: (text) => setState(() {
                    password = text;
                  }),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: appPadding / 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      onTap: () => goForgotPassword(),
                      child: Text(
                        'forgot password',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: appPadding / 2,
                ),
                BlockRaisedButton(
                  label: 'Sign in',
                  color: Colors.white,
                  textColor: primaryColor,
                  action: runSignin,
                ),
                SizedBox(
                  height: appPadding / 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    InkWell(
                      onTap: () => goSignUp(),
                      child: Text(
                        'Register ',
                        style: TextStyle(color: yellowColor, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: appPadding * 2,
                )
              ],
            ),
          ),
          // indicator(loading),
        ],
      ),
    );
  }
}
