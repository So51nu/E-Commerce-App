import 'package:flutter/material.dart';
import 'otp_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController mobileController = TextEditingController();
  bool loading = false;

  Future<void> sendOTP() async {
    String mobile = mobileController.text.trim();

    if (mobile.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter mobile number")),
      );
      return;
    }

    setState(() => loading = true);

    final url = Uri.parse("http://192.168.1.10:8000/auth/send-otp/"); // ← CHANGE IP

    final response = await http.post(
      url,
      body: jsonEncode({"mobile": mobile}),
      headers: {"Content-Type": "application/json"},
    );

    setState(() => loading = false);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("OTP for testing: ${data['otp_for_testing']}");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTPPage(mobile: mobile),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send OTP")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: mobileController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Mobile Number",
              ),
            ),
            SizedBox(height: 20),
            loading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: sendOTP,
              child: Text("Send OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
