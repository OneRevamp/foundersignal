import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:founder_signal/core/database/app_database.dart';

void main() {
  test('reflections can be written to and read from local SQLite', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);

    await database.into(database.reflections).insert(
          ReflectionsCompanion.insert(
            createdAt: DateTime.utc(2026, 1, 1),
            matterToday: const Value('Made meaningful progress'),
          ),
        );

    final entries = await database.select(database.reflections).get();

    expect(entries, hasLength(1));
    expect(entries.single.matterToday, 'Made meaningful progress');
  });
}
