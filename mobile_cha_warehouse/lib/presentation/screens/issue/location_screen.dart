import 'package:ditredi/ditredi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/check_info_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/check_info_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/issue_state.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/list_container_screen.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class LocationScreen extends StatefulWidget {
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final _cubes = _generateCubes();
  final _controller = DiTreDiController(
    rotationX: -20,
    light: vector.Vector3(-0.5, -0.5, 0.5),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.west, //mũi tên back
            color: Colors.white,
          ),
          onPressed: () {
            // BlocProvider.of<CheckListBloc>(context)
            //     .add(CheckListEventBackClicked(timestamp: DateTime.now()));
            // AlertDialogTwoBtnCustomized(
            //   context: context,
            //   title: "Bạn có chắc?",
            //   desc: "Khi nhấn nút Trở về, mọi dữ liệu sẽ không được lưu",
            //   onPressedBtn1: () {
            //     Navigator.pop(context);
            //   },
            // ).show();
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xff001D37), //màu xanh dương đậm
        //nút bên phải
        title: const Text(
          'Vị trí hàng hóa cần lấy',
          style: TextStyle(fontSize: 22), //chuẩn
        ),
      ),
      endDrawer: DrawerUser(),
      body: BlocBuilder<IssueBloc, IssueState>(
        builder: (context, state) {
          if (state is LoadingLocationState) {
            return CircularLoading();
          } else {
            return SafeArea(
              child: Flex(
                crossAxisAlignment: CrossAxisAlignment.start,
                direction: Axis.vertical,
                children: [
                  SizedBox(
                    height: 20 * SizeConfig.ratioHeight,
                  ),
                  Center(
                    child: Text(
                      locationContainer[0].shelfId +
                          '.' +
                          locationContainer[0].rowId.toString() +
                          '.' +
                          locationContainer[0].cellId.toString(),
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: DiTreDiDraggable(
                      controller: _controller,
                      child: DiTreDi(
                        figures: _cubes.toList(),
                        controller: _controller,
                      ),
                    ),
                  ),
                  Center(
                    child: CustomizedButton(
                        text: 'Quét QR',
                        onPressed: () async {
                          // quy trình test
                          // BlocProvider.of<CheckInfoBloc>(context).add(
                          //     CheckInfoEventRequested(
                          //         timeStamp: DateTime.now(),
                          //         basketID: basketIssueId));
                          // Navigator.pushNamed(
                          //     context, '/confirm_container_screen');
                          // quy trình thực tế
                          Navigator.pushNamed(
                              context, '/qr_scanner_issue_screen');
                        }),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

Iterable<Cube3D> _generateCubes() sync* {
  final colors = [
    Color(0xff001D20),
    Color(0xff001D30),
    Color(0xff001D40),
    Color(0xff001D50),
    Color(0xff001D60),
    Color(0xff001D70),
    // Color(0xff945305),
    // Color(0xffBD6B09),
    // Color(0xffD0770B),
    // Color(0xffEC870E),
    // Color(0xffF09C42),
    // Color(0xffF5B16D),
    // Color(0xffFACE9C),
    // Color(0xffFDE2CA),
  ];

  const count = 5;
  for (int x = count; x > 0; x--) {
    for (int y = count; y > 0; y--) {
      for (int z = count; z > 0; z--) {
        if (x == locationContainer[0].sliceId &&
            y == locationContainer[0].levelId &&
            z == locationContainer[0].id) {
          yield Cube3D(
            2,
            vector.Vector3(
              x.toDouble() * 3,
              y.toDouble() * 5,
              z.toDouble() * 3,
            ),
            color: Colors.red,
          );
        } else {
          yield Cube3D(
            2,
            vector.Vector3(
              x.toDouble() * 3,
              y.toDouble() * 5,
              z.toDouble() * 3,
            ),
            color: colors[(colors.length - y) % colors.length],
          );
        }
      }
    }
  }
}
