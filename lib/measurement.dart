import 'package:flutter/material.dart';
import 'dart:async';
import 'drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class measurementPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<measurementPage> {
  var token, id, total, jsondata, height, weight, biceps, chest, waist;
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
    var response = await http.get("http://139.59.66.2:9000/stapi/v1/measurment/", headers: <String, String>{'authorization': "Token " +token});
    jsondata = json.decode(response.body);
    height = (jsondata['results'][0]['height']);
    weight = (jsondata['results'][0]['weight']);
    biceps = (jsondata['results'][0]['biceps']);
    chest  = (jsondata['results'][0]['chest']);
    waist  = (jsondata['results'][0]['waist']);
    setState(() { token; jsondata; });
  }
  @override	
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Measurements', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: new SingleChildScrollView(
        child: Column( 
          mainAxisSize: MainAxisSize.min,    
          children: <Widget>[   
            forMeasurement()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  
          Navigator.push(  
            context,  
            MaterialPageRoute(builder:(context) => editMeasurement()),  
          );  
        },
        child: Icon(Icons.edit),
        backgroundColor: Colors.blue,
      ),
    );
  }
  Widget forMeasurement(){
    return Column(children: <Widget>[
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text('Height :- ', style: TextStyle(fontSize: 18)),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: new Text(height.toString() ?? "default", style: TextStyle(fontSize: 18),),
        ),
      ]),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: new Text('Weight :- ',style: TextStyle(fontSize: 18)),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: new Text(weight.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: new Text('Biceps :- ', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: new Text(biceps.toString() ?? 'default', style: TextStyle(fontSize: 18),),
        ),
      ]),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: new Text('Chest :-', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: new Text(chest.toString() ?? 'default', style: TextStyle(fontSize: 18)),
        ),
      ]),
      new Divider(color: Colors.black),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: new Text('Waist :-', style: TextStyle(fontSize: 18),),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: new Text(waist.toString() ?? 'default', style: TextStyle(fontSize: 18)),
        ),
      ]),
      new Divider(color: Colors.black),
    ]);
  }
}
class editMeasurement extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MeasurementState();
}
class MeasurementState extends State<editMeasurement>{
  var token, id, jsonData;
  final storage = new FlutterSecureStorage();
  FocusNode myFocusNode = new FocusNode();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bicepsController = TextEditingController();
  TextEditingController chestController  = TextEditingController();
  TextEditingController waistController  = TextEditingController();

  Upload(String height,String weight,String biceps,String chest,String waist) async {
    var readData   = await storage.read(key: 'loginData');
    var jsonLogin  = json.decode(readData);
    token = jsonLogin['token'];
    id = jsonLogin['id'].toString();
    Map data = {
      'user': id,
      'height': heightController.text,
      'weight': weightController.text,
      'biceps': bicepsController.text,
      'chest':  chestController.text,
      'waist':  waistController.text,
    };
    var response = await http.post("http://139.59.66.2:9000/stapi/v1/measurment/", body: data, headers: <String, String>{'authorization': "Token " +token});
    jsonData = json.decode(response.body);
    print(jsonData);
    if(response.statusCode == 201){
      AlertDialog alert = AlertDialog(  
        title: new Text('Simple Alert'),  
        content: new Text('Your data has been submitted successfully.'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.push(  
                context,  
                MaterialPageRoute(builder:(context) => measurementPage()),  
              );
            },
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
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Measurements', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextFormField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0),
                  hintText: 'Height :-',
                  // prefixIcon: Text("Phone",style: TextStyle(color: Colors.black, fontSize: 15))
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextFormField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0),
                  hintText: 'Weight :-',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextFormField(
                controller: bicepsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0),
                  hintText: 'Biceps :-',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextFormField(
                controller: chestController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0),
                  hintText: 'Chest :-',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextFormField(
                controller: waistController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0),
                  hintText: 'Waist :-',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 220.0),
              child: RaisedButton(
                color: Colors.blue, 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text('UPDATE',style: TextStyle(color: Colors.white,fontSize: 18),),
                onPressed: () => Upload(heightController.text, weightController.text, bicepsController.text, chestController.text, waistController.text),
              ),  
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  
          Navigator.push(  
            context,  
            MaterialPageRoute(builder: (context) => measurementPage()),  
          );  
        },
        child: Icon(Icons.cancel),
        backgroundColor: Colors.red,
      ),
    );
  } 
}