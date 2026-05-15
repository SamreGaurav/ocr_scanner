import 'package:flutter/material.dart';
import 'package:scanner_app/features/cards/presentation/view/card_screen.dart';
import 'package:scanner_app/features/passbook/presentation/view/passbook_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scanner App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Scan Card"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CardScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Scan Passbook"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PassbookScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}