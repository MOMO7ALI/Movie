import 'package:hive/hive.dart';
import 'movie.dart';

class MovieAdapter extends TypeAdapter<Movie> {
  @override
  final typeId = 0;

  @override
  Movie read(BinaryReader reader) {
    return Movie(id: reader.readString());
  }

  @override
  void write(BinaryWriter writer, Movie obj) {
    writer.writeString(obj.id!);
  }
}
