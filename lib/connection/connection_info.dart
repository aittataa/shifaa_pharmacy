import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:injectable/injectable.dart';

abstract class ConnectionChecker {
  Future<bool> get isConnected;
  DataConnectionChecker dataConnectionChecker;
}

@LazySingleton(as: ConnectionChecker)
class ConnectionInfo implements ConnectionChecker {
  DataConnectionChecker dataConnectionChecker;

  @override
  Future<bool> get isConnected => dataConnectionChecker.hasConnection;
}
