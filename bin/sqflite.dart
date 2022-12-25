import 'drift.data.dart';
import 'package:drift/drift.dart';

Future<void> initSqflite() async {
  final database = MyDatabase();

  await database
      .into(database.categories)
      .insert(CategoriesCompanion.insert(description: 'my first category'));

  final allCategories = await database.select(database.categories).get();
  print('Categories in database: $allCategories');
}
