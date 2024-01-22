// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'highlights.dart';

// // **************************************************************************
// // TypeAdapterGenerator
// // **************************************************************************

// class HighlightsAdapter extends TypeAdapter<Highlights> {
//   @override
//   final int typeId = 2;

//   @override
//   Highlights read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return Highlights(
//       highlightsKey: fields[0] as String,
//       url: fields[1] as String,
//       type: fields[2] as String,
//     );
//   }

//   @override
//   void write(BinaryWriter writer, Highlights obj) {
//     writer
//       ..writeByte(3)
//       ..writeByte(0)
//       ..write(obj.highlightsKey)
//       ..writeByte(1)
//       ..write(obj.url)
//       ..writeByte(2)
//       ..write(obj.type);
//   }

//   @override
//   int get hashCode => typeId.hashCode;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is HighlightsAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }
