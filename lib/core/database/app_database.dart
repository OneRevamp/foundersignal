import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class Reflections extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get matterToday => text().withDefault(const Constant(''))();
  TextColumn get avoidedDecision => text().withDefault(const Constant(''))();
  TextColumn get additionalNotes => text().withDefault(const Constant(''))();
}

class AttentionLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  TextColumn get category => text()();
  IntColumn get durationMinutes => integer().withDefault(const Constant(0))();
  TextColumn get source => text().withDefault(const Constant('manual'))();
}

class DeepWorkSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  TextColumn get objective => text().withDefault(const Constant(''))();
  IntColumn get plannedMinutes => integer().withDefault(const Constant(0))();
  IntColumn get completedMinutes => integer().withDefault(const Constant(0))();
}

class Signals extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get contentId => text().unique()();
  TextColumn get title => text()();
  TextColumn get body => text()();
  TextColumn get category => text().nullable()();
  TextColumn get actionItem => text().nullable()();
  DateTimeColumn get publishedAt => dateTime()();
  DateTimeColumn get cachedAt => dateTime()();
}

class Lessons extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get contentId => text().unique()();
  TextColumn get title => text()();
  TextColumn get body => text()();
  TextColumn get category => text().nullable()();
  DateTimeColumn get publishedAt => dateTime()();
  DateTimeColumn get cachedAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();
}

class WeeklyReviews extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get weekStarting => dateTime()();
  TextColumn get narrative => text()();
  DateTimeColumn get generatedAt => dateTime()();
}

@DriftDatabase(
  tables: [
    Reflections,
    AttentionLogs,
    DeepWorkSessions,
    Signals,
    Lessons,
    WeeklyReviews,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'founder_signal.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
