import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/controllers/count_controller.dart';
import 'package:getx_example/screens/other_screen.dart';

class HomeScreen extends StatelessWidget {
  final CounterController counterController = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Cliks: ${counterController.counter.value}'),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(OtherScreen(), transition: Transition.zoom);
                },
                child: Text('Open Other Screen'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterController.increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
