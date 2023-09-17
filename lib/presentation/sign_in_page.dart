import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/src/widgets/placeholder.dart';

class TeamsPage extends StatefulWidget {
  TeamsPage({super.key});

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  String firstResponse = "";

  String secondResponse = "";
  String salt = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Center(
              child: Image.asset("assets/digi_logo_pdf.png"),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6))),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6))),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () {
                secondResponse = hashPassword(emailController.text, salt);
                setState(() {});
              },
              child: const Text(
                "Sign in",
              ),
            ),
            const Divider(
              color: Colors.black45,
            ),
            OutlinedButton(
              onPressed: () {
                setState(() {});
                Navigator.of(context).pushNamed('signup');
              },
              child: const Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }

  String generateSalt() {
    final random = Random.secure();
    final saltBytes = List<int>.generate(16, (i) => random.nextInt(255));

    salt = base64UrlEncode(saltBytes);
    setState(() {});
    return salt;
  }

  String hashPassword(String password, String salt) {
    final codec = Utf8Codec();
    final passwordBytes = codec.encode(password);
    final saltBytes = base64Url.decode(salt); // Buradaki decode'i kaldırın.

    final response = sha256.convert([...saltBytes, ...passwordBytes]);
    setState(() {});
    print("first response =$response");
    return response.toString();
  }
}
