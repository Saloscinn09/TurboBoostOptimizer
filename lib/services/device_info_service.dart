import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:battery_plus/battery_plus.dart';

class DeviceInfoService {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  final Battery _battery = Battery();

  Future> getDeviceInfo() async {
    String model = 'Desconhecido';
    String manufacturer = 'Desconhecido';
    int androidSdk = 29;

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      model = androidInfo.model;
      manufacturer = androidInfo.manufacturer;
      androidSdk = androidInfo.version.sdkInt;
    }

    int batteryLevel = await _battery.batteryLevel;
    BatteryState batteryState = await _battery.batteryState;

    return {
      'model': model,
      'manufacturer': manufacturer.toUpperCase(),
      'androidSdk': androidSdk,
      'batteryLevel': batteryLevel,
      'isCharging': batteryState == BatteryState.charging,
    };
  }
}
