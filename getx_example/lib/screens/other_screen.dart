import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/controllers/count_controller.dart';

class OtherScreen extends StatelessWidget {
  final CounterController _counterController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "Screen was clicked ${_counterController.counter.value} times."),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Open Other Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
