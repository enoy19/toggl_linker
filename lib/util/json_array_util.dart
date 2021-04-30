import 'dart:convert';

List<T> fromJsonArray<T>(
    String jsonArrayString, T Function(Map<String, dynamic> element) builder) {
  final List<dynamic> jsonArray = jsonDecode(jsonArrayString);
  return jsonArray.map((e) => e as Map<String, dynamic>).map(builder).toList();
}
