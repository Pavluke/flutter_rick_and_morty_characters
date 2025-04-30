import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty_characters/core/data/models/base_entity.dart';
import 'package:flutter_rick_and_morty_characters/core/data/models/base_entity_filter.dart';
import 'package:flutter_rick_and_morty_characters/core/data/models/info.dart';
import 'package:flutter_rick_and_morty_characters/core/domain/repositories/i_entities_repository.dart';
import 'package:flutter_rick_and_morty_characters/core/domain/repositories/i_logger.dart';
import 'package:flutter_rick_and_morty_characters/core/presentation/entities_cubit/entities_cubit_status.dart';
import 'package:flutter_rick_and_morty_characters/core/services/api_client/api_client.dart';

part 'entities_state.dart';

abstract class IEntitiesCubit<E extends BaseEntity>
    extends Cubit<EntitiesState<E>> {
  IEntitiesCubit({
    required ApiClient apiClient,
    required IEntitiesRepository<E> entitiesRepository,
    required ILogger logger,
  }) : _apiClient = apiClient,
       _repository = entitiesRepository,
       _logger = logger,
       super(EntitiesState<E>());
  final ApiClient _apiClient;
  final IEntitiesRepository<E> _repository;
  final ILogger _logger;

  ApiClient get apiClient => _apiClient;

  Future<void> fetchEntities() async {
    try {
      final json = await _apiClient.getAll<E>(filter: state.filter);
      final entities = (json['results'] as List).map(fromJson).toList();
      final paginationInfo = PaginationInfo.fromJson(json['info']);
      emit(
        state.copyWith(
          entities: entities,
          paginationInfo: paginationInfo,
          status: EntitiesCubitStatus.loaded,
        ),
      );
      await _repository.updateAll(state.entities);
    } on DioException catch (_) {
      final entities = await _repository.getAllEntities();
      emit(
        state.copyWith(
          entities: entities,
          paginationInfo: PaginationInfo(),
          status: EntitiesCubitStatus.loaded,
        ),
      );
    } catch (e, st) {
      _logger.error(e, st);
      emit(state.copyWith(status: EntitiesCubitStatus.error));
    }
  }

  Future<void> fetchMoreEntities() async {
    try {
      if (state.paginationInfo.canLoadMore && !state.status.isLoading) {
        if (!state.status.isError) {
          emit(state.copyWith(status: EntitiesCubitStatus.loading));
        }
        final json = await _apiClient.getAll<E>(
          page: state.paginationInfo.next,
          filter: state.filter,
        );
        List<E> entities = ([
          ...state.entities,
          ...(json['results'] as List).map(fromJson),
        ]);
        final paginationInfo = PaginationInfo.fromJson(json['info']);
        emit(
          state.copyWith(
            entities: entities,
            paginationInfo: paginationInfo,
            status: EntitiesCubitStatus.loaded,
          ),
        );
        await _repository.updateAll(state.entities);
      }
    } on DioException catch (_) {
    } catch (e, st) {
      _logger.error(e, st);
      if (state.errorMsg != e) {
        emit(state.copyWith(status: EntitiesCubitStatus.error, errorMsg: '$e'));
      }
    }
  }

  Future<void> setFilters(BaseEntityFilter filter) async {
    emit(state.copyWith(filter: filter, status: EntitiesCubitStatus.loading));
    await fetchEntities();
  }

  Future<void> clearFilters() async {
    emit(state.withoutFilters.copyWith(status: EntitiesCubitStatus.loading));
    await fetchEntities();
  }

  Future<void> clearCache() async {
    await _repository.clear();
    emit(EntitiesState<E>());
    await fetchEntities();
  }

  E fromJson(dynamic json);
}
