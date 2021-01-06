import 'package:flutter/material.dart';
import 'dart:async';
import 'drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class activePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<activePage> {
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
    var response = await http.get("http://139.59.66.2:9000/stapi/v1/location/", headers: <String, String>{'authorization':"Token " +token});
    print(response.statusCode);
    jsondata = json.decode(response.body);
    print(jsondata);
    total = jsondata['count'];
    setState(() { token; jsondata; });
  }
  @override	
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Active Location', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Column(children: [
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
                  child: Column(children: [
                    Row(children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20,20,0,0),
                        child: Text("Reply Time: " +jsondata['results'][i]['interval'] ?? 'default', style: TextStyle(fontSize: 20)),
                      ),
                    ]),
                    Row(children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20,30,0,0),
                        child: Text("Request: " +jsondata['results'][i]['utimestamp'].substring(0,10) ?? 'default', style: TextStyle(color: Colors.grey,fontSize: 13)),
                      ),
                    ]),
                    Row(children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20,10,0,0),
                        child: Text("Response: " +jsondata['results'][i]['timestamp'].substring(0,10) ?? 'default', style: TextStyle(color: Colors.grey,fontSize: 13)),
                      ),
                    ]),
                    Row(children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20,10,0,0),
                        child: Text("Working: " +jsondata['results'][i]['working'].toString() ?? 'default', style: TextStyle(color: Colors.grey,fontSize: 13)),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(100,10,0,0),
                        child: Text("Location: " +jsondata['results'][i]['location'].toString() ?? 'default', style: TextStyle(color: Colors.grey,fontSize: 13)),
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
    );
  }
}  