import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

/// A basic BLoC observer for debugging
class SimpleBlocObserver extends BlocObserver {
  final log = Logger('SimpleBlocObserver');

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log.info(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log.info(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log.warning(error);
    super.onError(bloc, error, stackTrace);
  }
}