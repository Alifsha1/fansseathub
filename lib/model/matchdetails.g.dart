// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matchdetails.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MatchDetailsAdapter extends TypeAdapter<MatchDetails> {
  @override
  final int typeId = 0;

  @override
  MatchDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MatchDetails(
      matchKey: fields[0] as String,
      team1: fields[1] as String,
      team2: fields[2] as String,
      imagePath1: fields[3] as String,
      imagePath2: fields[4] as String,
      time: fields[5] as String,
      date: fields[6] as String,
      category: fields[7] as String,
      gameno: fields[8] as String,
      typeofgame: fields[9] as String,
      stadium: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MatchDetails obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.matchKey)
      ..writeByte(1)
      ..write(obj.team1)
      ..writeByte(2)
      ..write(obj.team2)
      ..writeByte(3)
      ..write(obj.imagePath1)
      ..writeByte(4)
      ..write(obj.imagePath2)
      ..writeByte(5)
      ..write(obj.time)
      ..writeByte(6)
      ..write(obj.date)
      ..writeByte(7)
      ..write(obj.category)
      ..writeByte(8)
      ..write(obj.gameno)
      ..writeByte(9)
      ..write(obj.typeofgame)
      ..writeByte(10)
      ..write(obj.stadium);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
