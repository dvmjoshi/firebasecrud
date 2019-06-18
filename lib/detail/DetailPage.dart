import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'charpowerbar.dart';
class DetailPage extends StatefulWidget {
  final DocumentSnapshot post;

  const DetailPage({Key key, this.post}) : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  double _sliderValue = 10.0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 450,
            decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(widget.post.data["imageurl"]),fit: BoxFit.cover)
            ),
          ),
          AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: (){},
              )
            ],
          ),

          Positioned(
            top: 280,
            left: 0,
            right: 0,
            bottom: 20,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18.0,0,18,0),
              child: Container(
              padding: const EdgeInsets.all(12.0),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xFFf8e1da),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60.0),
                        topRight: Radius.circular(60.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 15.0),
                          blurRadius: 15.0),
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, -10.0),
                          blurRadius: 10.0),
                    ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        RadialProgress(image: widget.post["imageurl"],),
                        SizedBox(width: 30,),
                        Column(
                          children: <Widget>[
                            Text(widget.post["name"], style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold
                            ),
                            ),
                            SizedBox(height: 10.0),
                            Text("Powers", style: TextStyle(
                                fontSize: 16.0
                            ),),
                            Text(widget.post["power"], style: TextStyle(
                                color: Colors.grey.shade700
                            ),),
                          ],
                        ),
                      ],

                ),

                    SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        Text("Nickname", style: TextStyle(
                            color: Colors.grey.shade700
                        ),),
                        Spacer(),
                  //      Icon(FontAwesomeIcons.fire, size: 14.0, color: Colors.pink.shade300,),
                        Text(widget.post["nickname"]),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex:1,
                          child: Slider(
                            activeColor: Colors.grey,
                            min: 10.0,
                            max: 100.0,
                            onChanged: (newRating) {
                              setState(() => _sliderValue = newRating);
                            },
                            value: _sliderValue,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("What do you think how powerful ${widget.post["name"]} is", style: TextStyle(
                            color: Colors.grey.shade700
                        )),
                        Spacer(),
                        Text('${_sliderValue.toInt()}',
                            style:TextStyle(fontSize: 25),
                        )
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Text("Description", style: TextStyle(
                        fontSize: 20.0
                    ),),
                    Text(widget.post.data["description"], style: TextStyle(
                        color: Colors.grey.shade700
                    ),),
                    SizedBox(height: 10.0),
                    Center(child: Icon(Icons.keyboard_arrow_up)),
                    InkWell(
                      onTap: (){
                        Alert(
                          image: Image.asset("assets/11.jpg"),
                            context: context,
                            title: "What else you wanna know?",
                            
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "GO Back",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                width: 100,
                              )
                            ]).show();
                      },
                      child: Center(child: Text("Know More character", style: TextStyle(
                          color: Colors.pink.shade300
                      ),),),
                    ),
                  ],
                ),
              ),
            ),
          ),


          Positioned(
            top: 265,
            right: 55,
            child: CircleAvatar(
                radius: 20.0,
                foregroundColor: Colors.grey,
                backgroundColor: Colors.grey.shade200,
                child: Icon(Icons.favorite_border)),
          )
        ],
      ),
    );
  }
}