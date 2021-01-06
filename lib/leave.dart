import 'package:flutter/material.dart';
import 'dart:async';
import 'drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class leavePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<leavePage> {
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
    var response = await http.get("http://139.59.66.2:9000/stapi/v1/leave/", headers: <String, String>{'authorization':"Token " +token});
    jsondata = json.decode(response.body);
    total = jsondata['count'];
    setState(() { token; jsondata; });
  }
  @override	
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Leave Applications', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(children: [
          Container(
            padding: EdgeInsets.fromLTRB(0,20,0,0),
            height: 500, width: 330,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: total,
              itemBuilder: (BuildContext context, int i) =>
              Card(
                elevation: 10,
                child: InkWell(
                  onTap: () {},
                  child: Column(children: [
                    Row(children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20,20,0,0),
                        child: Text('Leave Application',style: TextStyle(fontSize: 20)),
                      ),
                    ]),
                    new Divider(color: Colors.grey),
                    Row(children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20,30,0,0),
                        child: Text("Start : " +jsondata['results'][i]['sdate'] ?? 'default', style: TextStyle(color: Colors.grey,fontSize: 13)),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20,30,0,0),
                        child: Text("End : " +jsondata['results'][i]['edate'] ?? 'default', style: TextStyle(color: Colors.grey,fontSize: 13)),
                      ),
                    ]),
                    Row(children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20,10,0,0),
                        child: Text(jsondata['results'][i]['reason'] ?? 'default', style: TextStyle(color: Colors.grey,fontSize: 13)),
                      ),
                    ]),
                    Row(children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20,10,0,0),
                        child: Text("Approval: " +jsondata['results'][i]['approval'].toString() ?? 'default', style: TextStyle(color: Colors.grey,fontSize: 13)),
                      ),
                    ]),
                    Container(padding: EdgeInsets.fromLTRB(0,20,0,0)),
                  ]),
                ),
              ),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  
          Navigator.push(  
            context,  
            MaterialPageRoute(builder: (context) => editLeavePage()),  
          );  
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
class editLeavePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new leaveState();
}
class leaveState extends State<editLeavePage> {
  FocusNode myFocusNode = new FocusNode();
  var token, id, agency, jsonData;
  final storage = new FlutterSecureStorage();
  TextEditingController sdateController = TextEditingController();
  TextEditingController edateController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  
  Upload(String sdate,String edate, String reason) async {
    var readData   = await storage.read(key: 'loginData');
    var jsonLogin  = json.decode(readData);
    token = jsonLogin['token'];
    id = (jsonLogin['id'].toString());
    agency = (jsonLogin['agency'].toString());
    Map data = { 
      'professional': id,
      'id': '',
      'sdate': sdateController.text,
      'edate': edateController.text,
      'reason':reasonController.text,
      'approval': 'Apply',
      'source': 'Android',
      'agency': agency
    };
    jsonData = null;
    var response = await http.post("http://139.59.66.2:9000/stapi/v1/leave/", body: data, headers: <String, String>{'authorization':"Token " +token});
    jsonData = json.decode(response.body);
    if(response.statusCode == 201){
      AlertDialog alert = AlertDialog(  
        title: new Text('Simple Alert'),  
        content: new Text('Your data has been submitted successfully.'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.push(  
              context,  
              MaterialPageRoute(builder:(context) => leavePage()),  
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
        title: Text('Leave Applications', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: ListView(children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: TextField(
              controller: sdateController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                labelText: 'Leave Start',
                labelStyle: TextStyle(color: myFocusNode.hasFocus ? Colors.red : Colors.black, fontSize: 14)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: TextField(
              controller: edateController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                labelText: 'Leave End',
                labelStyle: TextStyle(color: myFocusNode.hasFocus ? Colors.red : Colors.black, fontSize: 14)
              ),
            ),
          ),
          Container(padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: TextField(
              controller: reasonController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                labelText: 'Leave Reason',
                labelStyle: TextStyle(color: myFocusNode.hasFocus ? Colors.red : Colors.black, fontSize: 18)
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 30.0,right: 230.0),
            child: RaisedButton(
              color: Colors.blue, shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)), 
              child: Text('SUBMIT',style: TextStyle(color: Colors.white,fontSize: 18)),
              onPressed: () => Upload(sdateController.text, edateController.text, reasonController.text),
            ),  
          ),  
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  
          Navigator.push(  
            context,  
            MaterialPageRoute(builder: (context) => leavePage()),  
          );  
        },
        child: Icon(Icons.cancel),
        backgroundColor: Colors.red,
      ),
    );
  }
}    