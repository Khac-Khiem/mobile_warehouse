import 'package:equatable/equatable.dart';

class WarehouseEmployee extends Equatable {
  String id;
  String firstName;
  String lastName;
  String dateOfBirth;
  WarehouseEmployee(this.id, this.firstName, this.lastName, this.dateOfBirth);
  @override
  // TODO: implement props
  List<Object?> get props => [id, firstName, lastName, dateOfBirth];
}
