import 'dart:async';
import 'package:formvalidation/src/bloc/validator.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //recuperar los datos del Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);
  Stream<bool> get formValidStream =>
      Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);
  //insertar valores al stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePasswordl => _passwordController.sink.add;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
