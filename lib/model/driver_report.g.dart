// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_report.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DriverReportAdapter extends TypeAdapter<DriverReport> {
  @override
  final int typeId = 0;

  @override
  DriverReport read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DriverReport(
      taskId: fields[0] as int,
      driverFullName: fields[1] as String,
      driverId: fields[2] as String,
      driverType: fields[3] as String,
      barcode: fields[4] as String,
      thumbnailImage: fields[5] as String,
      taskStatus: fields[6] as String,
      isUploadedToServer: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, DriverReport obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.taskId)
      ..writeByte(1)
      ..write(obj.driverFullName)
      ..writeByte(2)
      ..write(obj.driverId)
      ..writeByte(3)
      ..write(obj.driverType)
      ..writeByte(4)
      ..write(obj.barcode)
      ..writeByte(5)
      ..write(obj.thumbnailImage)
      ..writeByte(6)
      ..write(obj.taskStatus)
      ..writeByte(7)
      ..write(obj.isUploadedToServer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverReportAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
