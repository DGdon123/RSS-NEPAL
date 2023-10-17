import 'package:equatable/equatable.dart';

class NewsModuleEntity extends Equatable {
  final int? id;
  final String? name;
   

   NewsModuleEntity({
     required this.id,
     required this.name,
   });

  @override
  List<Object?> get props => [id!, name!];
   

   @override 
   bool get stringify => true;

  }