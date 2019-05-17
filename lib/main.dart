import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new LoginPage(),
      theme: new ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 300));

    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.easeOut);

    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.green,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage("assets/profile_pic.jpeg"),
            fit: BoxFit.cover,
            color: Colors.black87,
            colorBlendMode: BlendMode.darken,
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new FlutterLogo(
                size: _iconAnimation.value * 100,
              ),
              new Form(
                child: new Theme(
                  data: new ThemeData(
                    brightness: Brightness.dark,
                    primarySwatch: Colors.teal,
                    inputDecorationTheme: new InputDecorationTheme(
                      labelStyle: new TextStyle(
                        color: Colors.teal,
                        fontSize: 20.0
                      )
                    )
                  ),
                  child: new Container(
                    padding: const EdgeInsets.all(40.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Enter Email",

                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Enter Password",
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        new Padding(padding: EdgeInsets.only(top: 40.0)),
                        new MaterialButton(
                          height: 50,
                          minWidth: 100,
                          color: Colors.teal,
                          textColor: Colors.white,
                          child: new Text("Login"),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NewsRoute()),
                            );
                          },
                          splashColor: Colors.blueAccent,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class NewsRoute extends StatefulWidget {
  @override
  _NewsRouteState createState() => _NewsRouteState();
}

class _NewsRouteState extends State<NewsRoute> with SingleTickerProviderStateMixin {

  TabController tabController;
  @override
  void initState(){
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose(){
    tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Retrieve News"),
      ),
      body: new TabBarView(
        children: <Widget>[
          new SecondRoute(),
          new LoginPage()
        ],
        controller: tabController,
      ),
      bottomNavigationBar: new Material(
        color: Colors.teal,
        child: new TabBar(
          controller: tabController,
          tabs: <Widget>[
            new Tab(
              icon: new Icon(Icons.new_releases),
            ),
            new Tab(
              icon: new Icon(Icons.bookmark),
            )
          ],
        ),
      ),
    );
  }
}

class SecondRoute extends StatefulWidget {
  @override
  SecondRouteState createState() => SecondRouteState();
}

class SecondRouteState extends State<SecondRoute> {

  final String url = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=22920e566522494fbd2b629ad2461b8f";
  List data;
  bool _isLoading;
  @override
  void initState(){
    super.initState();
    _isLoading = true;
    this.getJsonData();
  }


  Future<String> getJsonData() async{
    var response = await http.get(
      //Encode the url
      Uri.encodeFull(url),
      headers: {"Accept": "application/json"}
    );
    print(response.body);

    setState(() {
      _isLoading = false;
      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson['articles'];
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: _isLoading
          ? new Center(
        child: CircularProgressIndicator(),
      )
          : new ListView.builder(
        itemCount: data == null ? 0:data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            child:new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: new Container(
                      child: new Text(data[index]['title']),
                      padding: const EdgeInsets.all(20.0),
                    ),
                  )
                ],
              ),
            ) ,
          );
        },
      ),
    );
  }
}

