import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_prefs_1/HomeUI.dart';

class LoginUI extends StatefulWidget {

  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {

  TextEditingController _unameController = TextEditingController();

  void _login(BuildContext context) async {
    String username = _unameController.text;
    if (username.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
      await prefs.setBool('userSession', true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeUI()),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _topPart(),
              _loginTitle(),
              _loginform(),
              _dividerText(),
              _socialIcon(),
            ],
          ),
        )
      ),
    );
  }

  Widget _topPart(){
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff6a11cb),
            Color(0xff2575fc),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
                SvgPicture.asset(
                  "assets/images/logo2.svg",
                  width: 100,
                  height: 100,
                  color: Colors.white,
                ),
              ],
            ),
          SizedBox(height: 20.0),
          Text(
            "Unleash Your Inner Sloth Today.",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            )
          ),
        ],
      )
    );
  }

  Widget _loginTitle(){
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.0),
            Text(
              "Sign In To Your Account.",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              )
            ),
            SizedBox(height: 10.0),
            Text(
                "Let's sign in to your account and get started.",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w200,
                  fontSize: 18,
                )
            ),
          ],
        )
    );
  }

  Widget _loginform(){
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Username",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 5),
          TextField(
            controller: _unameController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2,
                )
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            "Password",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 5),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_outline),
              suffixIcon: Icon(Icons.visibility_off_outlined),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  )
              ),
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: (){
                _login(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff6a11cb),
              padding: EdgeInsets.symmetric(vertical:20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign In",
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 16,
                 ),
                ),
                SizedBox(width: 8.0),
                Icon(Icons.logout_outlined, color: Colors.white),
              ],
            ),
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(onPressed: (){},
                  child: Text(
                      "Sign Up",
                    style: TextStyle(
                      color: Color(0xff6a11cb),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ),
            ],
          ),
          SizedBox(height: 1),
          Center(
            child: TextButton(
              onPressed: (){},
              child: Text(
                "Forgot Password",
                style: TextStyle(
                  color: Color(0xff6a11cb),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dividerText(){
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Colors.grey.shade300,
              thickness: 0.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "or",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.grey.shade300,
              thickness: 0.5,
            ),
          ),
        ],
      )
    );
  }

  Widget _socialIcon(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _SocialIconCont("assets/images/facebook.svg"),
        SizedBox(width: 16.0),
        _SocialIconCont("assets/images/twitter.svg"),
        SizedBox(width: 16.0),
        _SocialIconCont("assets/images/google.svg"),
      ],
    );
  }

  Widget _SocialIconCont(String URL){
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SvgPicture.asset(
        URL,
        width: 24,
        height: 24,
      ),
    );
  }

}