import 'dart:async';

enum Action { show, hide }

class LoginBloc {
  final _stateStreamController = StreamController<Action>();
  StreamSink<Action> get eventSink => _stateStreamController.sink;
  Stream<Action> get eventStream => _stateStreamController.stream;

  LoginBloc() {
    var obscure;
    eventStream.listen((event) {
      if (event == Action.show) {
        obscure = false;
      } else if (event == Action.hide) {
        obscure = true;
      }
    });
  }
}
