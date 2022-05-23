import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/domain/entities/storage_slot.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/check_info_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/check_info_state.dart';
import 'package:mobile_cha_warehouse/presentation/screens/inventory/qr_inventory.dart';
import 'package:mobile_cha_warehouse/presentation/screens/stockcard/stockcard_screen.dart';
import 'package:mobile_cha_warehouse/presentation/widget/exception_widget.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

import '../../../constant.dart';
import '../../../function.dart';

class InventoryScreen extends StatelessWidget {
  String containerId = '';
  String itemId = '';
  String itemName = '';
  Location location = Location('A', 0, 0, 0, 0, 0);
  int quantity = 0;
  String mass = '';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
               Navigator.pushNamed(context, '/qr_inventory_screen');
              },
              icon: const Icon(
                Icons.west,
                color: Colors.white,
              )),
          backgroundColor: Color(0xff001D37),
          title: Text('Kiểm kê',
              style: TextStyle(fontSize: 22 * SizeConfig.ratioFont)),
        ),
        endDrawer: DrawerUser(),
        body: BlocBuilder<CheckInfoBloc, CheckInfoState>(
            builder: (context, checkInfoState) {
          if (checkInfoState is CheckInfoStateLoading) {
            return CircularLoading();
          } else if (checkInfoState is CheckInfoStateFailure) {
            //lỗi
            return Center(
              child: Column(
                children: [
                  ExceptionErrorState(
                    height: 300,
                    title: "Không tìm thấy dữ liệu",
                    message:
                        "Rổ này có thể \nđã được lấy ra khỏi kho, \nvui lòng kiểm tra lại.",
                    imageDirectory: 'lib/assets/sad_commander.png',
                    imageHeight: 100,
                  ),
                  CustomizedButton(
                    text: "Quét lại",
                    bgColor: Constants.mainColor,
                    fgColor: Colors.white,
                    onPressed: () async {
                      Navigator.pushNamed(context, '/qr_inventory_screen');
                    },
                  ),
                ],
              ),
            );
          }
          //state này là CheckInfoStateSuccess
          else {
            //dùng if nhưng mục đích là để ép kiểu, do không dùng as để ép được
            if (checkInfoState is CheckInfoStateSuccess) {
              //
              containerId = checkInfoState.basket.id;
              itemId = checkInfoState.basket.product.id;
              itemName = checkInfoState.basket.product.name;
              quantity = checkInfoState.basket.actualQuantity;
              // mass = checkInfoState.basket.product.piecesPerKilogram
              location = checkInfoState.basket.storageSlot;
            }

            return SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10 * SizeConfig.ratioHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 350 * SizeConfig.ratioWidth,
                      child: Row(
                        children: [
                          Column(
                              children: labelTextList
                                  .map((text) => LabelText(
                                        text,
                                      ))
                                  .toList()),
                          SizedBox(
                            width: 15 * SizeConfig.ratioWidth,
                          ),
                          Column(children: [
                            TextInput(containerId),
                            TextInput(itemId),
                            TextInput(itemName),
                            TextInput(location.shelfId +
                                '.' +
                                location.rowId.toString() +
                                "." +
                                location.cellId.toString() +
                                "_" +
                                location.sliceId.toString() +
                                "." +
                                location.levelId.toString() +
                                "." +
                                location.id.toString()),
                            TextInput(quantity.toString()),
                          ])
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20 * SizeConfig.ratioHeight,
                    ),
                    Column(
                      children: [
                        CustomizedButton(
                          text: "Xác nhận",
                          bgColor: Constants.mainColor,
                          fgColor: Colors.white,
                          onPressed: () async {
                            scanQRInventoryresult = '-1';
                            Navigator.pushNamed(
                                context, '/qr_inventory_screen');
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        }));
  }
}

List<String> labelTextList = [
  "Mã QR/Mã rỗ:",
  "Mã sản phẩm:",
  "Tên sản phẩm:",
  "Vị trí:",
  "Khối/số lượng:",
];

class InventoryData {
  String containerId;
  String itemId;
  double plannedQuantity;
  double actualQuantity;
  InventoryData(
      {required this.containerId,
      required this.itemId,
      required this.plannedQuantity,
      this.actualQuantity = 0});
}

//quét mã qr sẽ cộng thêm 1 inventorydata vào list
List<InventoryData> textFieldContent = [];

class LabelText extends StatelessWidget {
  String text;
  LabelText(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10 * SizeConfig.ratioHeight),
      alignment: Alignment.centerRight,

      width: 120 * SizeConfig.ratioWidth,
      height: 55 * SizeConfig.ratioHeight,
      //color: Colors.amber,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 18 * SizeConfig.ratioFont, fontWeight: FontWeight.bold),
      ),
    );
  }
}
