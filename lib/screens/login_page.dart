import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xff7c94b6),
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.purple.withOpacity(0.20), BlendMode.dstATop),
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
              child: const Text('Login', style: TextStyle(color: Colors.white),),
              onPressed: () {

            },)
          ],
        ),
      ),
    );
  }
}
