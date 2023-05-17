import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../util/helper/logger_helper.dart';
import '../../util/helper/stream/stream_data.dart';
import '../../util/helper/stream/stream_event.dart';
import '../../util/mixin/stream_action.dart';
import '../../util/mixin/vending_action.dart';
import '../../util/service/service_locator.dart';
import '../repository/base_repository.dart';

abstract class BaseViewModel extends ChangeNotifier with StreamAction, VendingAction {
  final LoggerHelper logger = locator<LoggerHelper>();

  void executeRequest<T>(
      {required BaseRepository repository, required Future<T> request, required Function success}) async {
    streamAction(StreamData(StreamEvent.loading, null));
    var result = await repository.executeNetworkRequest(request: request);
    streamAction(StreamData(StreamEvent.retrieved, null));
    result.fold(
      (error) {
        logger.e('$error', error, StackTrace.current);
        streamAction(StreamData(StreamEvent.error, error.toString()));
      },
      (value) {
        success(Right<Object, T>(value));
      },
    );
  }
}
