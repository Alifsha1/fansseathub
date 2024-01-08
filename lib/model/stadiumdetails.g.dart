// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stadiumdetails.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StadiumDetailsAdapter extends TypeAdapter<StadiumDetails> {
  @override
  final int typeId = 1;

  @override
  StadiumDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StadiumDetails(
      stadiumKey: fields[0] as String,
      imagePathstadium: fields[1] as String,
      stadiumname: fields[2] as String,
      stands1: fields[3] as String,
      ticketcharge1: fields[4] as String,
      stands2: fields[5] as String,
      ticketcharge2: fields[6] as String,
      stands3: fields[7] as String,
      ticketcharge3: fields[8] as String,
      stands4: fields[9] as String,
      ticketcharge4: fields[10] as String,
      standsac1: fields[11] as String,
      ticketchargeac1: fields[12] as String,
      standsac2: fields[13] as String,
      ticketchargeac2: fields[14] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StadiumDetails obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.stadiumKey)
      ..writeByte(1)
      ..write(obj.imagePathstadium)
      ..writeByte(2)
      ..write(obj.stadiumname)
      ..writeByte(3)
      ..write(obj.stands1)
      ..writeByte(4)
      ..write(obj.ticketcharge1)
      ..writeByte(5)
      ..write(obj.stands2)
      ..writeByte(6)
      ..write(obj.ticketcharge2)
      ..writeByte(7)
      ..write(obj.stands3)
      ..writeByte(8)
      ..write(obj.ticketcharge3)
      ..writeByte(9)
      ..write(obj.stands4)
      ..writeByte(10)
      ..write(obj.ticketcharge4)
      ..writeByte(11)
      ..write(obj.standsac1)
      ..writeByte(12)
      ..write(obj.ticketchargeac1)
      ..writeByte(13)
      ..write(obj.standsac2)
      ..writeByte(14)
      ..write(obj.ticketchargeac2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StadiumDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
