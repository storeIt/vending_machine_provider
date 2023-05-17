import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../constant/network_constant.dart';
import '../../util/exception/failure.dart';
import '../../util/service/data_base/db_service.dart';
import '../../util/service/networking/rest_api_service.dart';
import '../../util/service/networking/retrofit_service.dart';
import '../../util/service/service_locator.dart';

abstract class BaseRepository {
  final RestClient restClient = locator<RetrofitService>().restClient;
  final DbService dbService = DbService.instance;

  Future<Either<Object, T>> executeNetworkRequest<T>({required Future request}) async {
    try {
      final response = await request;
      return Right(response);
    } catch (error) {
      final failure = _onNetworkError(error, StackTrace.current);
      return Left(failure);
    }
  }

  Failure _onNetworkError(Object error, StackTrace stackTrace) {
    switch (error.runtimeType) {
      case DioError:
        return ServerFailure(_mapDioErrorToMessage(error as DioError), error, StackTrace.current);
      case SocketException:
        return ConnectionFailure(error, StackTrace.current);
      case FormatException:
        return FormatFailure(error, StackTrace.current);
    }
    return UnhandledFailure(error, StackTrace.current);
  }

  String _mapDioErrorToMessage(DioError error) {
    switch (error.type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.connectionError:
        return NetworkConstant.serverError;
      case DioErrorType.badResponse:
        return NetworkConstant.badResponse;
      case DioErrorType.cancel:
        return NetworkConstant.cancelRequest;
      case DioErrorType.unknown:
        return NetworkConstant.unknownException;
      case DioErrorType.badCertificate:
        return NetworkConstant.badCertificate;
    }
  }
}
