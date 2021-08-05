import 'package:flutter/material.dart';
import 'package:flutter_location_tracker/constants/asset_path.dart';
import 'package:flutter_location_tracker/constants/controllers.dart';
import 'package:flutter_location_tracker/models/device_model.dart';
import 'package:flutter_location_tracker/screens/home/widgets/single_device_draggable.dart';
import 'package:flutter_location_tracker/widgets/custom_text.dart';

class DeviceWidget extends StatelessWidget {
  final DeviceModel device;

  const DeviceWidget({Key? key, required this.device}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        appController.changeActiveDeviceTo(device);
        appController.changeActiveDraggableWidgetTo(SingleDeviceDraggable());
      },
      leading: Image.asset(
        _returnImage(),
        width: 45,
      ),
      title: CustomText(
        text: device.name.toString(),
        size: 18,
        weight: FontWeight.bold,
      ),
      subtitle: CustomText(
        text: "Last log 2 days ago",
        color: Colors.grey,
      ),
    );
  }

  String _returnImage() {
    if (device.os == "android") {
      return android;
    } else {
      return iphone;
    }
  }
}
