import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'login_success.dart';
import 'login_failed.dart';


main(){
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      home: Scaffold(appBar: AppBar(title: const Center(child: Text('PROJECT001\n(Form Login)')),),
      //body: Text('Data'),
      body: const MyProject001(),
      ),
    );
  }
}


class MyProject001 extends StatefulWidget {
  const MyProject001({Key? key}) : super(key: key);

  @override
  State<MyProject001> createState() => _MyProject001State();
}

class _MyProject001State extends State<MyProject001> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _login() async{
    var url = Uri.parse("http://192.168.100.100:8087/flutter/login_.php");
    var response = await http.post(url,body: {"username":usernameController.text, "password":passwordController.text});

    var datauser = jsonDecode(response.body);

    if(datauser !=''){
      print('Login Success');

        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => MyApp1(),
          ),
        );

    }else{
      //print('Login Failed');
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => MyApp2(),
          ),
        );

    }

  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const Image(
            height: 100,
            width: 100,
            image: AssetImage("assets/images/medium.jpg"),),


          const Text('Sign-In'),

          Container(
            padding: const EdgeInsets.all(8),
            child: TextField(
              keyboardType: TextInputType.phone,
              controller: usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username'
              ),
            ),
          ),


          Container(
            padding: const EdgeInsets.all(8),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password'
              ),
            ),
          ),

          ElevatedButton(onPressed: (){
              _login();
          }, child: const Text('LOGIN'))

        ],
      ),
    );
  }
}
