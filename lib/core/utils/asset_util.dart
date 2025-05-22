import 'dart:convert';

import 'package:flutter/services.dart';

class AssetUtil {
  AssetUtil._();

  static Future<String> readFileFromBundle(String file) async {
    return await rootBundle.loadString(file);
  }

  static Future<List<String>> getFileAssetPath(String folderPath) async {
    final String assetManifest = await rootBundle.loadString(
      'AssetManifest.json',
    );
    final Map<String, dynamic> assetManifestMap = json.decode(assetManifest);

    final List<String> result = assetManifestMap.keys
        .where(
          (key) => key.contains(folderPath),
        )
        .toList();
    return result;
  }

  static Future<Map<String, dynamic>> loadJsonAsset(String fileName) async {
    final String jsonString = await rootBundle.loadString(
      'assets/sql/$fileName.json',
    );
    final data = json.decode(jsonString);
    return data;
  }
}
