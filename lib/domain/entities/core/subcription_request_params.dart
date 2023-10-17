import 'package:equatable/equatable.dart';

class SubscriptionRequestParams extends Equatable {
  final String? remarks;

  SubscriptionRequestParams({
    required this.remarks,
  });

  toJson() => {'remarks': remarks};

  @override
  List<Object?> get props => [remarks!];
}
