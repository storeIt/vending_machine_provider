import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

import '../../feature/products/model/product.dart';
import '../../util/helper/event_bus_event/update_categories.dart';
import '../../util/helper/logger_helper.dart';
import '../../util/helper/stream/stream_data.dart';
import '../../util/helper/stream/stream_event.dart';
import '../../util/mixin/stream_action.dart';
import '../../util/mixin/vending_action.dart';
import '../../util/service/service_locator.dart';
import '../repository/base_repository.dart';

abstract class BaseViewModel extends ChangeNotifier with StreamAction, VendingAction {
  final LoggerHelper logger = locator<LoggerHelper>();
  final EventBus eventBus = locator<EventBus>();
  final List<Product> products = [];

  bool _refill = false;
  bool get refill => _refill;
  set refill(bool value) {
    _refill = value;
    notifyListeners();
  }

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

  Future<void> fetchProducts(BaseRepository repository) async {
    executeRequest(
      repository: repository,
      request: repository.restClient.fetchProducts(),
      success: (Right<Object, List<Product>> products) async {
        await _saveProducts(repository, products.value);
      },
    );
  }

  Future<void> _saveProducts(BaseRepository repository, List<Product> prs) async {
    await repository.dbClient.insertAll(prs).then((value) {
      products.clear();
      if (value.isNotEmpty) {
        products.addAll(prs);
        if (refill == true) {
          refill = false;
        }
        eventBus.fire(UpdateCategories());
      }
    });
  }
}
