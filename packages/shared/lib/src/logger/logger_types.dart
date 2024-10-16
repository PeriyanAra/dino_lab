import 'package:loggy/loggy.dart';

abstract class _LoggerConstants {
  static const presentationLoggyName = 'Presentation Loggy';
  static const domainLoggyName = 'Domain Loggy';
  static const dataLoggyName = 'Data Loggy';
  static const analyticLoggyName = 'Analytic Loggy';
}

/// UI and bloc.
class PresentationLoggy implements LoggyType {
  @override
  final loggy = Loggy<PresentationLoggy>(_LoggerConstants.presentationLoggyName);
}

/// Services and etc.
class DomainLoggy implements LoggyType {
  @override
  final loggy = Loggy<DomainLoggy>(_LoggerConstants.domainLoggyName);
}

/// Network and local cache layer.
class DataLoggy implements LoggyType {
  @override
  final loggy = Loggy<DataLoggy>(_LoggerConstants.dataLoggyName);
}

class AnalyticLoggy implements LoggyType {
  @override
  final Loggy<AnalyticLoggy> loggy = Loggy<AnalyticLoggy>(_LoggerConstants.analyticLoggyName);
}
