import 'package:flutter/material.dart';
import 'dart:async';
import 'drawer.dart';

class aboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<aboutPage> {
  @override	
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('About', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body:new SingleChildScrollView(
        child: Column( 
          mainAxisSize: MainAxisSize.min,    
          children: <Widget>[   
            _editTitleTextField()
          ],
        ),
      ),
    );
  }
  Widget _editTitleTextField(){
    return Column(children: <Widget>[
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20,20,0,0),
          height: 200,width: 350,
          child: Card(
            child: Column(children: <Widget>[
              Row(children: [
                IconButton(icon: Icon(Icons.add_location)),
                Container(
                  child: Center(child: Text('Experienced Guards',style: TextStyle(fontSize: 20))),
                ),
              ]),
              Column(children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10,20,0,0),
                  child: Text('Security Troops company provides the physical security protection services to residential, commercial, construction and industrial sites within the India.', overflow: TextOverflow.ellipsis, maxLines: 4, style: TextStyle(color: Colors.grey, fontSize: 14)),
                ),
              ]),                    
            ]),
          ),
        ),
      ]),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20,20,0,0),
          height: 200,width: 350,
          child: Card(
            child: Column(children: <Widget>[
              Row(children: [
                IconButton(icon: Icon(Icons.add_location)),
                Container(
                  child: Center(child: Text('Effective Price',style: TextStyle(fontSize: 20))),
                ),
              ]),
              Column(children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10,20,0,0),
                  child: Text('ST provides you best security services at very effective price that fits your pockets.', overflow: TextOverflow.ellipsis, maxLines: 4, style: TextStyle(color: Colors.grey, fontSize: 14)),
                ),
              ]),                    
            ]),
          ),
        ),
      ]),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20,20,0,0),
          height: 200,width: 350,
          child: Card(
            child: Column(children: <Widget>[
              Row(children: [
                IconButton(icon: Icon(Icons.add_location)),
                Container(
                  child: Center(child: Text('Genuine Review',style: TextStyle(fontSize: 20))),
                ),
              ]),
              Column(children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10,20,0,0),
                  child: Text('Security Troops services and its online platform enable us to provide you with just right solution to meet the requirements of the industry.', overflow: TextOverflow.ellipsis, maxLines: 4, style: TextStyle(color: Colors.grey, fontSize: 14)),
                ),
              ]),                    
            ]),
          ),
        ),
      ]),
      Row(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20,20,0,0),
          height: 200,width: 350,
          child: Card(
            child: Column(children: <Widget>[
              Row(children: [
                IconButton(icon: Icon(Icons.add_location)),
                Container(
                  child: Center(child: Text('Commitment to Safety',style: TextStyle(fontSize: 20))),
                ),
              ]),
              Column(children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10,20,0,0),
                  child: Text('Through our experties, ingrity, dignity, Commitment and excellence in all we do, we are decided to provide quality service to our sociaty in an effective responsive and professional way', overflow: TextOverflow.ellipsis, maxLines: 5, style: TextStyle(color: Colors.grey, fontSize: 14)),
                ),
              ]),                    
            ]),
          ),
        ),
      ]),
      // Row(children: [
      //   Container(
      //     padding: EdgeInsets.fromLTRB(20,20,0,0),
      //     height: 200,width: 350,
      //     child: Card(
      //       child: Column(children: <Widget>[
      //         Row(children: [
      //           IconButton(icon: Icon(Icons.add_location)),
      //           Container(
      //             child: Center(child: Text('Experienced Guards',style: TextStyle(fontSize: 20))),
      //           ),
      //         ]),
      //         Column(children: [
      //           Container(
      //             padding: EdgeInsets.fromLTRB(10,20,0,0),
      //             child: Text('Security Troops company provides the physical security protection services to residential, commercial, construction and industrial sites within the India.', overflow: TextOverflow.ellipsis, maxLines: 4, style: TextStyle(color: Colors.grey, fontSize: 14)),
      //           ),
      //         ]),                    
      //       ]),
      //     ),
      //   ),
      // ]),
    ]);
  }
}