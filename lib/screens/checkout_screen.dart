import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:music_player/widgets/common_input.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final contactController = TextEditingController();
  final payController = TextEditingController();

  //stuid is userID - in this case I use const value for it
  String stuid = "User001";

  final formKey = GlobalKey<FormState>();

  bool isSubmitting = false;

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isSubmitting = true;
      });

      final firstname = firstNameController.text.trim();
      final lastname = lastNameController.text.trim();
      final email = emailController.text.trim();
      final contact = contactController.text.trim();
      final pay = payController.text.trim();

      final url = Uri.parse('https://example.lk/payment.php');

      try {
        //getting response from payment gateway
        final response = await http.post(
          url,
          body: {
            'firstname': firstname,
            'lastname': lastname,
            'email': email,
            'tele': contact,
            'stuid': stuid,
            'pay': pay,
          },
        );

        //if success
        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          final redirectUrl = responseData['data']['gateway']['redirect_url'];

          Uri redirectUri = Uri.parse(redirectUrl);
          await canLaunchUrl(redirectUri)
              ? await launchUrl(redirectUri)
              : print("error");
        } else {
          throw Exception('Failed to launch URL');
        }
      } catch (error) {
        print(error);
      } finally {
        setState(() {
          isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: isSubmitting
            ? const CircularProgressIndicator(
                color: Colors.amber,
              )
            : Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text("Amount (LKR) : 1500"),
                    CustomTextField(
                        title: "F name", controller: firstNameController),
                    CustomTextField(
                        title: "L name", controller: lastNameController),
                    CustomTextField(
                        title: "Email", controller: emailController),
                    CustomTextField(
                        title: "Phone Number", controller: contactController),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: submitForm,
                      child: const Text('Proceed to Payment'),
                    ),
                  ],
                )),
      )),
    );
  }
}
