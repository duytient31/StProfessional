import 'package:flutter/material.dart';  
import 'dart:async';
import 'home.dart';
import 'active.dart';
import 'attendance.dart';
import 'leave.dart';
import 'gallery.dart';
import 'measurement.dart';
import 'jobs.dart';
import 'earn.dart';
import 'contact.dart';
import 'about.dart';
import 'changePassword.dart';
import 'profile.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NavDrawer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<NavDrawer>{
  var fn, mail, image;
  final storage = new FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    getData();
  }
  Future<String> getData() async{   
    var readData   = await storage.read(key: 'loginData');
    var jsonLogin  = json.decode(readData);
    fn   = jsonLogin['first_name'];
    mail = jsonLogin['email'];
    image = await storage.read(key: 'image');
    setState((){ fn; mail; image; jsonLogin; });
  }
  @override  
  Widget build(BuildContext context) {  
    return Drawer(
      child: new ListView( 
        children: <Widget>[
          new UserAccountsDrawerHeader(
            currentAccountPicture: new GestureDetector(
              onTap: () => Navigator.push(  
                context,  
                MaterialPageRoute(builder:(context)=>profilePage()),  
              ),
              child: new CircleAvatar(
                backgroundImage: new NetworkImage(image ?? 'default'),
              ),
            ),
            decoration: BoxDecoration(color: Colors.white),
            accountName: new Text(fn ?? 'default', style: TextStyle(color: Colors.black)),
            accountEmail: new Text(mail ?? 'default', style: TextStyle(color: Colors.blue)),
          ),
          new ListTile(  
            leading: Icon(Icons.home, color: Colors.black),
            title: Text('Home', style: TextStyle(color: Colors.black, fontSize: 15)),
            onTap: () => Navigator.push(  
              context,  
              MaterialPageRoute(builder: (context) => homePage()),  
            ), 
          ),
          new Divider(),
          new ListTile(  
            leading: Icon(Icons.person, color: Colors.black),
            title: Text('Active', style: TextStyle(color: Colors.black, fontSize: 15),),
            onTap: () => Navigator.push(  
              context,  
              MaterialPageRoute(builder: (context) => activePage()),  
            ),  
          ),
          new Divider(),  
          new ListTile(  
            leading: Icon(Icons.thumb_up , color: Colors.black),
            title: Text('Attendance', style: TextStyle(color: Colors.black, fontSize: 15),),
            onTap: () => Navigator.push(  
              context,  
              MaterialPageRoute(builder: (context) => attendancePage()),  
            ), 
          ),
          new Divider(),  
          new ListTile(  
            leading: Icon(Icons.home, color: Colors.black),
            title: Text('Leaves', style: TextStyle(color: Colors.black, fontSize: 15),),
            onTap: () => Navigator.push(  
              context,  
              MaterialPageRoute(builder: (context) => leavePage()),  
            ),  
          ),
          new Divider(),
          new ListTile(  
            leading: Icon(Icons.collections, color: Colors.black),
            title: Text('Gallery', style: TextStyle(color: Colors.black, fontSize: 15),),
            onTap: () => Navigator.push(  
              context,  
              MaterialPageRoute(builder: (context) => galleryPage()),  
            ),
          ),
          new Divider(),
          new ListTile(  
            leading: Icon(Icons.home, color: Colors.black),
            title: Text('Measurements', style: TextStyle(color: Colors.black, fontSize: 15),),
            onTap: () => Navigator.push(  
              context,  
              MaterialPageRoute(builder: (context) => measurementPage()),  
            ), 
          ),
          new Divider(),
          new ListTile(  
            leading: Icon(Icons.work, color: Colors.black),
            title: Text('Jobs/Vacancy', style: TextStyle(color: Colors.black, fontSize: 15),),
            onTap: () => Navigator.push(  
              context,  
              MaterialPageRoute(builder: (context) => jobsPage()),  
            ),  
          ),
          new Divider(),
          new ListTile(  
            leading: Icon(Icons.home, color: Colors.black),
            title: Text('Invite & Earn', style: TextStyle(color: Colors.black, fontSize: 15),),
            onTap: () => Navigator.push(  
              context,  
              MaterialPageRoute(builder: (context) => earnPage()),  
            ),
          ),
          new Divider(),
          new ListTile(  
            leading: Icon(Icons.local_phone , color: Colors.black),
            title: Text('Contact', style: TextStyle(color: Colors.black, fontSize: 15),),
            onTap: () => Navigator.push(  
              context,  
              MaterialPageRoute(builder: (context) => ContactPage()),  
            ),
          ),
          new Divider(),
          new ListTile(  
            leading: Icon(Icons.search, color: Colors.black),
            title: Text('About', style: TextStyle(color: Colors.black, fontSize: 15),),
            onTap: () => Navigator.push(  
              context,  
              MaterialPageRoute(builder: (context) => aboutPage()),  
            ),
          ),
          new Divider(),
          new ListTile( 
            leading: Icon(Icons.person, color: Colors.black), 
            title: Text('Change Password', style: TextStyle(color: Colors.black, fontSize: 15),),
            onTap: () => Navigator.push(  
              context,  
              MaterialPageRoute(builder: (context) => pasChangePage()),  
            ), 
          ),
        ],  
      ),
    );
  }
} 