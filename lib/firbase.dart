import 'package:firebasecrud/user.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'detail/DetailPage.dart';
import 'fetchdata.dart';

class home extends StatefulWidget {
  home() : super();

  final String title = "STUFF";
  @override
  homeState createState() => homeState();
}

class homeState extends State<home> {
  navigateDetail(DocumentSnapshot post){
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => DetailPage(post:post)
    ));

  }
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  validateFormAndSave() {
    print("Validating Form...");
    if (_key.currentState.validate()) {
      print("Validation Successful");
      _key.currentState.save();
      print('Name ');
      print('Age ');
    } else {
      print("Validation Error");
    }
  }




  //
  bool showTextField = false;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  String collectionName = "Users";
  bool isEditing = false;
  User curUser;

  homeState();


  getUsers() {
    return Firestore.instance.collection(collectionName).snapshots();
  }

  addUser() {
    User user = User(name: controller1.text,nickname: controller2.text,
       imageurl: controller3.text, power: controller4.text,
      description: controller5.text

     );
    try {
      Firestore.instance.runTransaction(
            (Transaction transaction) async {
          await Firestore.instance
              .collection(collectionName)
              .document()
              .setData(user.toJson());
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  add() {
    if (isEditing) {
      // Update
      update(curUser, controller1.text,controller2.text,controller3.text,controller4.text,controller5.text);
      setState(() {
        isEditing = false;
      });
    } else {
      addUser();
    }
    controller1.text = '';
  }

  update(User user,String newname,String newnikename,String newimage,String newpower, String newdescription) {
    try {
      Firestore.instance.runTransaction((transaction) async {
        await transaction.update(user.reference, {'name':newname ,'nickname':newnikename,'imageurl':newimage,
      'power':newpower,  'description':newdescription});
      });
    } catch (e) {
      print(e.toString());
    }
  }

  delete(User user) {
    Firestore.instance.runTransaction(
          (Transaction transaction) async {
        await transaction.delete(user.reference);
      },
    );
  }

  Widget buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getUsers(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.hasData) {
          print("Documents ${snapshot.data.documents.length}");
          return buildList(context, snapshot.data.documents);
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => buildListItem(context, data)).toList(),
    );
  }

  Widget buildListItem(BuildContext context, DocumentSnapshot data) {
    final   user = User.fromSnapshot(data);

    return Column(
      children: <Widget>[
        Padding(
          key: ValueKey(user.name),
          padding: EdgeInsets.all( 8.0),
          child: Container(
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap:(){
                    navigateDetail(data);
                  },
//                  onDoubleTap:(){
//                    setUpdateUI(user);
//                  } ,
//                  onLongPress: ()
//                  {  delete(user);},
                  child: UserData(
                    nickname: user.nickname,
                    Name: user.name,
                    des: user.description,
                    Image: user.imageurl,
                    power: user.power,
                  ),
                ),
                /*ListTile(
                  title: Text(user.description),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // delete
                      delete(user);
                    },
                  ),

                  onTap: () {
                    // update
                    setUpdateUI(user);
                  },
                ),*/
              ],
            ),
          ),
        ),
      ],
    );
  }

  setUpdateUI(User user) {
    controller1.text = user.name;
    setState(() {
      showTextField = true;
      isEditing = true;
      curUser = user;
    });
  }

  button() {
    return Container(
      padding: const EdgeInsets.only(top: 50.0),
      width: double.infinity,
      alignment: Alignment.center,
      child: RaisedButton(
        onPressed: () {
          add();
          setState(() {
            showTextField = false;
          });
        },
        color: Color(0xFF2B65F9),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 8.0, vertical: 12.0),
          child: Text(
            'JOIN',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
teamdata()=>ListView(children:<Widget>[

  Stack(children: <Widget>[    Padding(
    padding: const EdgeInsets.fromLTRB(0,90,0,0),
    child: Image.asset("assets/t2.jpg"),
  ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          'Wanna Join Gaurdian Of Tech ',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  Padding(
    padding: const EdgeInsets.fromLTRB(20.0,70,20,20),
    child: Container(
      width: double.infinity,
      //  height: ScreenUtil.getInstance().setHeight(520),
      decoration: BoxDecoration(
          color: Color.fromRGBO(255,250,250, 100),
          borderRadius: BorderRadius.circular(8.0),
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
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _key,
          autovalidate: _validate,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 15,
                  controller: controller1,
                  decoration: InputDecoration(
                    labelText: "Name", hintText: "Enter name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)
                  ),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller2,
                  maxLength: 15,
                  decoration: InputDecoration(
                    labelText: "Nikename", hintText: "Enter Nikename",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    ),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller3,
                  decoration: InputDecoration(
                    labelText: "Imageurl", hintText: "Enter Image url",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    ),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller4,
                  decoration: InputDecoration(
                    labelText: "Power", hintText: "Enter Power.",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    ),),
                  keyboardType: TextInputType.text,
                  maxLength: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 120,
                  controller: controller5,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: "Description", hintText: "Enter Description",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    ),),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              button(),
            ],
          ),
        ),
      ),
    ),
  )],),



]);

    return Scaffold(
      // backgroundColor: Color(0xFFF9EFEB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Guardinas",style: TextStyle(color: Colors.grey),),
        centerTitle: true,

        leading: IconButton(
            color: Colors.grey,
            icon: Icon(Icons.arrow_back), onPressed: (){
         Navigator.pop(context);
        }),
        actions: <Widget>[
          IconButton(
            splashColor: Colors.grey,
            icon: Icon(Icons.add_circle_outline,color: Colors.grey,),
            onPressed: () {
              setState(() {
                showTextField = !showTextField;
              });
            },
          ),
        ],
      ),
      body:
          PageView(
            children: <Widget>[
              //buildBody(context),
              showTextField?
              teamdata():  buildBody(context),

            ],
          )

    );
  }

}