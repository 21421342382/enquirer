import 'package:okito/okito.dart';

class KStorage {
  static void init() {
    OkitoStorage.init(storageName: "arc_open_enquirer_data");
  }

  static bool contains(String key) {
    return KStorage.read(key: key) != null;
  }

  static void remove(String key) {
    OkitoStorage.removeKey(key);
  }

  static void write<T>({required String key, required T value}) {
    OkitoStorage.write(key, value);
  }

  static T? read<T>({required String key}) {
    return OkitoStorage.read<T>(key);
  }
}
