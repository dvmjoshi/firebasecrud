import 'package:flutter/material.dart';

class UserData extends StatelessWidget {

  final String Image;
  final String Name;
  final String  des;
  final String nickname;
  final String power;
  UserData({
    Key key, this.Image, this.Name,this.des,this.nickname,this.power
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28.0,12,28,12),
      child: new Container(
        width: double.infinity,
        height: 380.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.grey.withOpacity(.3), width: .2),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 15.0),
                  blurRadius: 15.0),
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, -10.0),
                  blurRadius: 10.0),
            ]),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: double.infinity,
                  height: 250.0,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(Image),
                  fit: BoxFit.fitHeight),
                    borderRadius: BorderRadius.circular(20.0)
                ),

              ),
            ),
            //Image.asset(imgUrl, width: 281.0, height: 191.0),
            Column(
              children: <Widget>[
                Hero(tag:Name,child: Text(Name, style: TextStyle(fontSize: 25.0, fontFamily: "Raleway"))),
                Text(nickname,
                    style: TextStyle(
                        color: Color(0xFFfeb0ba),
                        fontSize: 20.0,
                        fontFamily: "Helvetica"))
              ],
            ),
            SizedBox(
              height: 4.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
             //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: () {

                    },
                  ),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}