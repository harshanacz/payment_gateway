import 'package:flutter/material.dart';
import 'package:music_player/const/colors.dart';
import 'package:music_player/screens/checkout_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
          child: Center(
        child: ElevatedButton(
          child: Text("Checkout"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CheckoutScreen()),
            );
          },
        ),
      )),
    );
  }
}
