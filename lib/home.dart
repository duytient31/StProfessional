import 'package:flutter/material.dart';
import 'dart:async';
import 'drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class homePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<homePage> {
  var token, jsondata, total;
  final storage = new FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    getData();
  }
  Future<String> getData() async{   
    var readData   = await storage.read(key: 'loginData');
    var jsonLogin  = json.decode(readData);
    token = jsonLogin['token']; 
    jsondata = null;
    var response = await http.get("http://139.59.66.2:9000/stapi/v1/work/", headers: <String, String>{'authorization':"Token " +token});
    jsondata = json.decode(response.body);
    total = jsondata['count'];
    setState(() { token; jsondata; });
  }
  @override	
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Home', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.notifications,color:Colors.white),
            onPressed: () {
              Navigator.push(  
                context,  
                MaterialPageRoute(builder:(context) =>editHomePage()),  
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(children: [
          Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(20,20,0,0),
              child: Text('My Active Duties', style: TextStyle(fontSize: 20)),
            ),
          ]),
          Container(
            padding: EdgeInsets.fromLTRB(0,20,10,0),
            height: 500, width: 330,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: total,
              itemBuilder: (BuildContext context, int i) =>
              Card(
                elevation: 10,
                child: InkWell(
                  onTap: () {},
                  child: Row(children: [
                    IconButton(icon: new Icon(Icons.accessibility)),
                    Container(
                      child: Text(jsondata['results'][i]['title'] ?? 'default', style: TextStyle(fontSize: 15)),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ]),
	    ),
    );
  }
}
class editHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new editState();
}
class editState extends State<editHomePage> {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column( children: <Widget>[
          Container(padding: EdgeInsets.fromLTRB(0,30,0,0)),
          Row(children: [
            Image.asset('assets/images/st-1024-logo.png',width: 100,height: 80),
            Column(children: [
              Text('Welcome at Security Troops',style: TextStyle(color: Colors.blue, fontSize: 18)),
              Text('Welcome to Security Troops Professionals.',style: TextStyle(fontSize: 12)),
              new Divider(color: Colors.grey),
            ]),
          ]),
        ]),
      ),
    );
  }
}   