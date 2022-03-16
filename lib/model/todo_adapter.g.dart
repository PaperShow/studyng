// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoAdapter extends TypeAdapter<Todo> {
  @override
  final int typeId = 0;

  @override
  Todo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Todo(
      description: fields[1] as String?,
      title: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RevenueAdapter extends TypeAdapter<Revenue> {
  @override
  final int typeId = 1;

  @override
  Revenue read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Revenue(
      transactiontype: fields[3] as dynamic,
      expense: fields[1] as dynamic,
      income: fields[0] as dynamic,
      title: fields[2] as dynamic,
      dateTime: fields[4] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Revenue obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.income)
      ..writeByte(1)
      ..write(obj.expense)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.transactiontype)
      ..writeByte(4)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RevenueAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
