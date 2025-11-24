import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 24),
              child: Text(
                'What do you want to watch?',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            )
          ],
        ),
      ),
    );
  }
}
