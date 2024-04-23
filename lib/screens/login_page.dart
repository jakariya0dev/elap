import 'dart:convert';
import 'package:elap/screens/dashboard.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:elap/screens/voter_list.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late SharedPreferences prefs;

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  void initState()  {
    initPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xff7c94b6),
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.purple.withOpacity(0.10), BlendMode.dstATop),
            image: const NetworkImage(
              'https://picsum.photos/200/300',
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('elap', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 52),),
            const SizedBox(height: 50),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Agent Phone',
                prefixIcon: const Icon(Icons.phone_android),
                suffixIcon: InkWell(
                  child: const Icon(Icons.close_rounded),
                  onTap: () {
                      phoneController.clear();
                  },
                )
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: isPasswordVisible,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Agent password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: InkWell(
                    child: Icon(isPasswordVisible ? Icons.visibility_off: Icons.visibility),
                    onTap: () {
                      isPasswordVisible = !isPasswordVisible;
                      setState(() {});
                    },
                  )
              ),
            ),
            const SizedBox(height: 32),
            MaterialButton(
              height: 50,
              minWidth: double.maxFinite,
              color: Colors.purple,
              onPressed: loginUser,
              child: const Text('Login', style: TextStyle(color: Colors.white),)
            )
          ],
        ),
      ),
    );
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  loginUser() async {

    if(phoneController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter Phone Number"),
        duration: Duration(milliseconds: 3000),
      ));
    }
    else if(passwordController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter Agent Password"),
        duration: Duration(milliseconds: 3000),
      ));
    }
    else{

      String url = "https://server.elep.app/api/v1/auth/agent-login";
      Map reqBody = {
        "phone" : phoneController.text,
        "password" : passwordController.text
      };
      var response = await http.post(
          Uri.parse(url),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(reqBody)
      );

      var jsonResponse = jsonDecode(response.body);

      if(jsonResponse['success']){

        Map<String, dynamic> decodedToken = JwtDecoder.decode(jsonResponse['data']['accessToken']);
        await prefs.setString('accessToken', jsonResponse['data']['accessToken']);
        await prefs.setString('userId', decodedToken['userId']);
        var userUrl = "https://server.elep.app/api/v1/agents/${decodedToken['userId']}";
        var jsonUserResponse = await http.get(
            Uri.parse(userUrl),
            headers: {"Content-Type":"application/json"}
        );

        var userResponse = jsonDecode(jsonUserResponse.body);

        prefs.setString('voteCenter', userResponse['data']['voteCenter']);

        Navigator.push(context, MaterialPageRoute(builder: (context) => const DashBoard()));

      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Login Failed!"),
          duration: Duration(milliseconds: 3000),
        ));
      }
      // print(response.body);
    }
  }
}
