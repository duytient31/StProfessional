import 'package:flutter/material.dart';
import 'dart:async';
import 'drawer.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class pasChangePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<pasChangePage> {
  var token,user, id, agency, jsonData;
  final storage = new FlutterSecureStorage();
  TextEditingController pasController = TextEditingController();
  TextEditingController nPasController = TextEditingController();
  TextEditingController cPasController = TextEditingController();
  
  Upload(String pas,String npas, String cpas) async {
    var readData   = await storage.read(key: 'loginData');
    var jsonLogin  = json.decode(readData);
    token = jsonLogin['token'];
    user  = jsonLogin['username'];
    Map data = {
      'password': pasController.text,
      'npassword': nPasController.text,
      'cpassword':cPasController.text,
      'username': user,
      'service': 'Professional',
    };
    jsonData = null;
    var response = await http.post("http://139.59.66.2:9000/stapi/v1/changepassword/", body: data, headers: <String, String>{'authorization':"Token " +token});
    jsonData = json.decode(response.body);
    if(response.statusCode == 200){
      AlertDialog alert = AlertDialog(  
        title: new Text('Simple Alert'),  
        content: new Text('Password changed successfully.'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.push(  
              context,  
              MaterialPageRoute(builder:(context) => homePage()),  
            ),
            color: Colors.blue,
            child: const Text('Okay'),
          ),
        ],    
      ); 
      showDialog(  
        context: context,  
        builder: (BuildContext context) {  
          return alert;  
        },  
      );
    }
    setState((){ token; jsonData; });
  }
  @override	
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Change Password', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
            Image.asset('assets/images/st-1024-logo.png',width: 100,height: 180),
            Container(padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0)),
            Container(
              child: TextField(
                obscureText: true,
                controller: pasController,
                decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                    labelText: 'Current Password',
                ),
              ),
            ),
            Container(
              child: TextField(
                obscureText: true,
                controller: nPasController,
                decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                  labelText: 'New Password',
                ),
              ),
            ),
            Container(
              child: TextField(
                obscureText: true,
                controller: cPasController,
                decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                  labelText: 'Conform Password',
                ),
              ),
            ),
            Container(
              padding:EdgeInsets.symmetric(horizontal:0,vertical: 15.0),
              child: RaisedButton(
                color: Colors.blue,
                child: Text('CHANGE PASSWORD',style: TextStyle(color: Colors.white,fontSize: 20),),                
                onPressed: () => Upload(pasController.text, nPasController.text, cPasController.text),
              ),  
            ),  
          ],
        )
	    ),
    );
  }
}  