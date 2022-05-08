import 'package:mobile_cha_warehouse/domain/entities/warehouse_employee.dart';

class WarehouseEmployeeModel extends WarehouseEmployee {
  WarehouseEmployeeModel(
      String id, String firstName, String lastName, DateTime dataOfBirth)
      : super(id, firstName, lastName, dataOfBirth);
  factory WarehouseEmployeeModel.fromJson(Map<String, dynamic> json) {
    return WarehouseEmployeeModel(
      json["id"],
      json["firstName"],
      json["lastName"],
      json["dateOfBirth"],
    );
  }
}
