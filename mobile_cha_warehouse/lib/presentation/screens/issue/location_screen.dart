import 'package:ditredi/ditredi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/issue_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/issue_state.dart';
import 'package:mobile_cha_warehouse/presentation/widget/exception_widget.dart';
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
            // ep State
            // BlocProvider.of<IssueBloc>(context)
            //     .add(TestIssueEvent(DateTime.now()));
           
            Navigator.pushNamed(context, '/list_container_screen');
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
          }
          if (state is LoadLocationFailState) {
            return Center(
              child: ExceptionErrorState(
                height: 300,
                title: "Không tìm thấy vị trí rổ",
                message: "Vui lòng kiểm tra lại đơn.",
                imageDirectory: 'lib/assets/sad_face_search.png',
                imageHeight: 140,
              ),
            );
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
                    child: Column(
                      children: [
                        Text(
                          locationContainer[0].shelfId +
                              '.' +
                              locationContainer[0].rowId.toString() +
                              '.' +
                              locationContainer[0].cellId.toString(),
                          style: const TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          locationContainer[0].sliceId.toString() +
                              '.' +
                              locationContainer[0].levelId.toString() +
                              '.' +
                              locationContainer[0].id.toString(),
                          style: const TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ],
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
    const Color(0xff001D20),
    const Color(0xff001D30),
    const Color(0xff001D40),
    const Color(0xff001D50),
    const Color(0xff001D60),
    const Color(0xff001D70),
  ];

  int countx = xAxis;
  int county = yAxis;
  int countz = zAxis;
  for (int x = countx; x > 0; x--) {
    for (int y = county; y > 0; y--) {
      for (int z = countz; z > 0; z--) {
        if (x == locationContainer[0].sliceId &&
            y == locationContainer[0].levelId &&
            z == zAxis - locationContainer[0].id + 1) {
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
