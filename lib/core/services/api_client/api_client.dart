import 'package:dio/dio.dart';
import 'package:flutter_rick_and_morty_characters/core/data/models/base_entity.dart';
import 'package:flutter_rick_and_morty_characters/core/data/models/base_entity_filter.dart';

class ApiClient {
  ApiClient({required Dio dio}) : _dio = dio;
  final Dio _dio;

  Dio get dio => _dio;

  Future<Map<String, dynamic>> getAll<T extends BaseEntity>({
    int? page = 1,
    BaseEntityFilter? filter,
  }) async {
    if (T == BaseEntity) {
      throw Exception("""Generic must be provided!
Example:
'''dart 
  await apiClient.getAll<Character>();
'''""");
    }
    final queryParameters = filter?.toJson() ?? {};
    queryParameters.addAll({'page': page});
    final response = await _dio.fetch(
      RequestOptions(
        responseType: ResponseType.json,
        method: 'GET',
        path: '${dio.options.baseUrl}/${T.toString().toLowerCase()}/',
        queryParameters: queryParameters,
      ),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getById<T extends BaseEntity>({
    required int id,
  }) async {
    if (T is BaseEntity) {
      throw Exception("""Function must generic provide!
Example:
'''dart 
  await apiClient.getAll<Character>();
'''""");
    }
    final response = await _dio.fetch(
      RequestOptions(
        responseType: ResponseType.json,
        method: 'GET',
        path: '${dio.options.baseUrl}/${T.toString().toLowerCase()}/$id',
      ),
    );
    return response.data;
  }

  Future<List<Map<String, dynamic>>> getByIds<T extends BaseEntity>({
    required List<int> ids,
  }) async {
    if (ids.length < 2) {
      final result = await getById<T>(id: ids.first);
      return [result];
    }
    final idsParam = ids.join(',');
    final response = await _dio.fetch(
      RequestOptions(
        responseType: ResponseType.json,
        method: 'GET',
        path: '${dio.options.baseUrl}/${T.toString().toLowerCase()}/$idsParam',
      ),
    );
    return response.data.cast<Map<String, dynamic>>();
  }
}
