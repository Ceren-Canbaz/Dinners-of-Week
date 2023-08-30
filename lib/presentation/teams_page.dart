import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TeamsPage extends StatelessWidget {
  TeamsPage({super.key});
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(6)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Icon(
                    Icons.group,
                    size: 54,
                  ),
                  TextField(
                    controller: textController,
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
