import 'package:firebasecrud/siginup/regform.dart';
import 'package:firebasecrud/signinform/CustomIcons.dart';
import 'package:firebasecrud/signinform/SocialIcons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../firbase.dart';
class Siginup extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<Siginup> {
  String _email;
  String   _password;
  //google sign
  /// GoogleSignIn googleauth = new GoogleSignIn();
  final formkey=new GlobalKey<FormState>();
  checkFields(){
    final form=formkey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }



  createUser()async{
    if (checkFields()){
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)
          .then((user){
        print('signed in as ${user.uid}');

        Navigator.of(context).pop();
        Navigator.of(context).pushNamed('/userpage');
      }).catchError((e){
        print(e);
      });
    }
  }
  bool _isSelected = false;

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Container(
                    height: 280,
                    child: Image.asset("assets/bat.jpg")),
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                    image:DecorationImage(image: AssetImage("assets/dvmcity.gif"),
                        fit: BoxFit.fitWidth)
                ),
              )
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 35.0),
              child: Column(
                children: <Widget>[
                  Column(

                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text("Your saviour",
                          style: TextStyle(
                              fontFamily: "Poppins-Bold",
                              fontSize: ScreenUtil.getInstance().setSp(28),
                              letterSpacing: .6,
                              fontWeight: FontWeight.bold)),
                      Text("Divyam is here",
                          style: TextStyle(
                              fontFamily: "Poppins-Bold",
                              fontSize: ScreenUtil.getInstance().setSp(28),
                              letterSpacing: .6,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(350),
                  ),
                  Form(
                      key: formkey,
                      child: SiginupFormCard(
                        validation: 'required',
                        saveemail: (value) => _email = value,
                        savepwd: (value) => _password = value,

                      )),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 12.0,
                      ),

                      SizedBox(
                        width: 8.0,
                      ),

                    ],
                  ),
                  Center(
                    child: InkWell(
                      onTap: createUser,
                      child: Container(
                        width: ScreenUtil.getInstance().setWidth(330),
                        height: ScreenUtil.getInstance().setHeight(100),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0xFF17ead9),
                              Color(0xFF6078ea)
                            ]),
                            borderRadius: BorderRadius.circular(6.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF6078ea).withOpacity(.3),
                                  offset: Offset(0.0, 8.0),
                                  blurRadius: 8.0)
                            ]),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: createUser,
                            child: Center(
                              child: Text("SIGNUP",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins-Bold",
                                      fontSize: 18,
                                      letterSpacing: 1.0)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),



                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
