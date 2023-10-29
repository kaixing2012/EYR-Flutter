import 'package:flutter_proj/shares/services/logging.service.dart';
import 'package:flutter_proj/states/redux/global_store/global.reducer.dart';
import 'package:flutter_proj/states/redux/router_store/router.reducer.dart';
import 'package:get_it/get_it.dart';
import 'package:redux/redux.dart';

mixin AlphaBase {
  final logger = GetIt.instance.get<LoggingService>();
  final globalStore = GetIt.instance.get<Store<GlobalState>>();

  RouterState get routerState => globalStore.state.router;
}
