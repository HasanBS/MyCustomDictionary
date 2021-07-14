import 'dart:convert';

import 'package:mycustomdictionary/logic/product/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static CacheManager? _instance;
  static CacheManager get instance {
    if (_instance != null) return _instance!;
    _instance = CacheManager._init();
    return _instance!;
  }

  late SharedPreferences preferences;

  CacheManager._init();

  String _key<T>(String id) {
    return '$T-$id';
  }

  Future<void> initpreferences(args) async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<bool> addCacheItem<T>(String id, T model) async {
    final _stringModel = jsonEncode(model);
    return await preferences.setString(_key<T>(id), _stringModel);
  }

  Future<bool> removeCacheItem<T>(String id) async {
    return await preferences.remove(_key<T>(id));
  }

  Future<bool> getCacheItem<T extends IBaseModel>(String id, IBaseModel model) {
    final cacheData = preferences.getString(_key<T>(id)) ?? '';
    final jsonMapModel = jsonDecode(cacheData);
    return model.fromJson(jsonMapModel);
  }

  List<T> getCacheList<T extends IBaseModel>(IBaseModel model) {
    final cacheDataList = preferences
        .getKeys()
        .where((element) => element.contains('$T-'))
        .map((e) => jsonDecode(e))
        .toList();
    if (cacheDataList.isNotEmpty) {
      return cacheDataList.map((e) => model.fromJson(e) as T).toList();
    }
    return [];
  }

  bool isCacheData<T>(String id) {
    return (preferences.getString(_key<T>(id)) ?? '').isNotEmpty;
  }
}
