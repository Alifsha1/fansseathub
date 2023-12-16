// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_details.dart';

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
      team1: fields[0] as String,
      team2: fields[1] as String,
      imagePath1: fields[2] as String,
      imagePath2: fields[3] as String,
      time: fields[4] as int,
      date: fields[5] as int,
      category: fields[6] as String,
      gameno: fields[7] as int,
      typeofgame: fields[8] as String,
      stadium: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MatchDetails obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.team1)
      ..writeByte(1)
      ..write(obj.team2)
      ..writeByte(2)
      ..write(obj.imagePath1)
      ..writeByte(3)
      ..write(obj.imagePath2)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.category)
      ..writeByte(7)
      ..write(obj.gameno)
      ..writeByte(8)
      ..write(obj.typeofgame)
      ..writeByte(9)
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
