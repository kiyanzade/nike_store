import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nike_store/data/product.dart';

final FavoritesManager favoritesManager = FavoritesManager();

class FavoritesManager {
  final _box = Hive.box<Product>('favorites');

    ValueListenable<Box<Product>> getValueListenable(){
      return _box.listenable();
    }

  static init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ProductAdapter());
    Hive.openBox<Product>('favorites');
  }

  void addFavorites(Product product) {
    _box.put(product.id, product);
  }

  void delete(Product product) {
    _box.delete(product.id);
  }

  List<Product> getAllFavorites() {
    return _box.values.toList();
  }

  bool isFavorites(Product product) {
    return _box.containsKey(product.id);
  }
}
