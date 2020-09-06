import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>   with SingleTickerProviderStateMixin {
  AnimationController controller;
  int _counter = 0;
  final myController = TextEditingController();
  ScrollController _scrollController = new ScrollController();


  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    controller.addListener(() {
print("KASS");
      setState(() {

        l[l.length-1].fontSize++;
      });
    });
  }

  double fontSize = 14.0;


  saveData(){
    Message  m = l[l.length-1];

  //  FirebaseFirestore.instance.enablePersistence();

    Map<String, dynamic> map  = Map();
    map.putIfAbsent("message", () => m.text);
    map.putIfAbsent("size", () => m.fontSize);

    //FirebaseFirestore.instance.collection('messages').doc(DateTime.now().toIso8601String()).set(map);


  }



  //double height = 14.0;

  List<Message> l = [];

String text = "";
  @override
  Widget build(BuildContext context) {

    return   Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Flutter Facts"),
      ),
      body: Column(children: <Widget>[

        Flexible(
          child: ListView.builder(
            controller: _scrollController,

            padding: EdgeInsets.all(8.0),
            reverse: false, //To keep the latest messages at the bottom
            itemBuilder: (_, int index) {

              if(index == l.length-1)
                {
                  return Padding(
                    child: Container(

                      child: Text(l[index].text, style: TextStyle(
                          fontSize: l[index].fontSize
                      ),),
                      color: Colors.black12,
                    ),
                    padding: EdgeInsets.all(20),
                  );
                }

              return Padding(
                child: Container(

                  child: Text(l[index].text, style: TextStyle(
                    fontSize: l[index].fontSize
                  ),),
                  color: Colors.black12,
                ),
                padding: EdgeInsets.all(20),
              );

              // l[index]
            },
            itemCount: l.length,
          ),),
        Divider(height: 1.0),
        Container(

          width: MediaQuery.of(context).size.width,
          height: 80,
          decoration: new BoxDecoration(color: Theme.of(context).cardColor),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width-120,
                  child: Container(
                      child:  TextFormField(
                        controller: myController,
                        onChanged: (e){
                          text = e;
                        },
                      )

                  ),
                ),
            Spacer(),
            GestureDetector(

             onTapDown: (_) {

               Message m = new Message(text, 14);
               l.add(m);
               print("SSS");

               _scrollController.jumpTo(_scrollController.position.maxScrollExtent);

               myController.text = "";
               setState(() {

               });
                controller.forward();},

              onTapUp: (_) {
                if (controller.status == AnimationStatus.forward) {
                  controller.stop();
                  fontSize = 14;
                  saveData();
                }
              },
            child: Container(height: 50,width: 50, color: Colors.black12,child: Icon(Icons.send),),
            )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}



class Message{

  String text;
  double fontSize ;

  Message(this.text, this.fontSize);


}
