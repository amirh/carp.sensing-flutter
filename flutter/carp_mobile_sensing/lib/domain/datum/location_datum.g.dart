// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationDatum _$LocationDatumFromJson(Map<String, dynamic> json) {
  return LocationDatum()
    ..$ = json[r'$'] as String
    ..id = json['id'] as String
    ..timestamp = json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String)
    ..deviceInfo = json['device_info'] == null
        ? null
        : DeviceInfo.fromJson(json['device_info'] as Map<String, dynamic>)
    ..latitude = (json['latitude'] as num)?.toDouble()
    ..longitude = (json['longitude'] as num)?.toDouble()
    ..accuracy = (json['accuracy'] as num)?.toDouble()
    ..altitude = (json['altitude'] as num)?.toDouble()
    ..speed = (json['speed'] as num)?.toDouble()
    ..speedAccuracy = (json['speed_accuracy'] as num)?.toDouble();
}

Map<String, dynamic> _$LocationDatumToJson(LocationDatum instance) {
  var val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(r'$', instance.$);
  writeNotNull('id', instance.id);
  writeNotNull('timestamp', instance.timestamp?.toIso8601String());
  writeNotNull('device_info', instance.deviceInfo);
  writeNotNull('latitude', instance.latitude);
  writeNotNull('longitude', instance.longitude);
  writeNotNull('accuracy', instance.accuracy);
  writeNotNull('altitude', instance.altitude);
  writeNotNull('speed', instance.speed);
  writeNotNull('speed_accuracy', instance.speedAccuracy);
  return val;
}
