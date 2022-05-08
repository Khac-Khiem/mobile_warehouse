// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mobile_cha_warehouse/domain/entities/container_inconsistency.dart';
// import 'package:mobile_cha_warehouse/function.dart';
// import 'package:mobile_cha_warehouse/presentation/bloc/blocs/edit_basket_bloc.dart';
// import 'package:mobile_cha_warehouse/presentation/bloc/states/edit_basket_state.dart';
// import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

// import '../../../constant.dart';

// class EditBasketScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(
//             Icons.west, //mũi tên back
//             color: Colors.white,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           }, //sự kiện mũi tên back
//         ),
//         backgroundColor: const Color(0xff001D37), //màu xanh dương đậm
//         //nút bên phải
//         title: const Text(
//           'Điều chỉnh rổ',
//           style: TextStyle(fontSize: 22), //chuẩn
//         ),
//       ),
//       endDrawer: DrawerUser(),
//       body: BlocBuilder<EditBasketBloc, EditBasketState>(
//         // ignore: missing_return
//         builder: (context, state) {
//           if (state is EditBasketStateRefreshLoading) {
//             return CircularLoading();
//           } else if (state is EditBasketStateRefreshSuccess) {
//             List<ContainerInconsistency> inconsistencyBasketsView = [];
//             inconsistencyBasketsView = state.inconsistencyContainers;
//             //Test thì dùng dòng dưới
//             //inconsistencyBasketsView = errorBaskets;
//             if (inconsistencyBasketsView.length != 0) {
//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 20 * SizeConfig.ratioHeight,
//                     ),
//                     Center(
//                       child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: inconsistencyBasketsView
//                               .where(
//                                   (errorBasket) => errorBasket.isFixed == false)
//                               .toList()
//                               .map((errorBasket) => BasketListTile(
//                                   inconsistencyBasket: errorBasket))
//                               .toList()),
//                     ),
//                     SizedBox(
//                       height: 30 * SizeConfig.ratioHeight,
//                     ),
//                     Text(
//                       "Có ${inconsistencyBasketsView.where((element) => element.isFixed == false).length} rổ cần điều chỉnh",
//                       style: TextStyle(
//                           fontSize: 16 * SizeConfig.ratioFont,
//                           fontStyle: FontStyle.italic),
//                     ),
//                     SizedBox(
//                       height: 30 * SizeConfig.ratioHeight,
//                     ),
//                   ],
//                 ),
//               );
//             } else {
//               // return Center(
//               //     child: ExceptionErrorState(
//               //   title: "Không có rổ cần điều chỉnh",
//               //   message:
//               //       "Các rổ đã được điều chỉnh hết, \nvui lòng xem lịch sử trên \nphần mềm máy tính",
//               //   imageDirectory: 'lib/assets/sad_face_search.png',
//               //   height: 350,
//               //   imageHeight: 160,
//               // ));
//             }
//           }
//           else if (state is EditBasketStateRefreshFailed) {
//             // if (state.errorPackage.errorCode == "SocketException") {
//             //   return Center(
//             //     child: ExceptionErrorState(
//             //       title: "Mất kết nối đến máy chủ",
//             //       message: "Vui lòng kiểm tra lại đường truyền",
//             //       height: 350,
//             //       imageHeight: 120,
//             //     ),
//             //   );
//             // }
//             // return Center(
//             //   child: ExceptionErrorState(
//             //     title: "Đã có lỗi xảy ra",
//             //     message: state.errorPackage.message,
//             //     imageDirectory: 'lib/assets/sad_commander.png',
//             //     height: 350,
//             //     imageHeight: 140,
//             //   ),
//             // );
//           }
        
//         },
       
//       ),
//     );
//   }
// }

// class BasketListTile extends StatelessWidget {
//   ContainerInconsistency inconsistencyBasket;

//   BasketListTile({required this.inconsistencyBasket});
//   @override
//   Widget build(BuildContext context) {
//     // ProductRepository productRepository =
//     //     new ProductRepository(httpClient: http.Client());
//     return GestureDetector(
//       child: Container(
//         width: 360 * SizeConfig.ratioWidth,
//         height: 110 * SizeConfig.ratioHeight,
//         decoration: const BoxDecoration(
//           border: Border(
//             bottom: const BorderSide(width: 0.5, color: Colors.grey),
        
//           ),
//         ),
//         child: Center(
//           child: ListTile(
//             title: Text(
//               "Vị trí ${inconsistencyBasket.shelfUnitId}",
//               style: TextStyle(
//                   fontSize: 25 * SizeConfig.ratioFont,
//                   color: Constants.mainColor,
//                   fontWeight: FontWeight.bold),
//             ),
//             subtitle: Text(
//                 "Mã SP: ${inconsistencyBasket.item.id} \n${inconsistencyBasket.goodsIssuId}",
//                 style:
//                     TextStyle(height: 2, fontSize: 16 * SizeConfig.ratioFont)),
//             trailing: Icon(Icons.chevron_right,
//                 size: 40 * SizeConfig.ratioWidth, color: Constants.mainColor),
//           ),
//         ),
//       ),
//       onTap: () {
//         // Navigator.push(
//         //     context,
//         //     MaterialPageRoute(
//         //         // builder: (_) => MultiBlocProvider(
//         //         //       providers: [
//         //         //         BlocProvider<EditPerBasketBloc>(
//         //         //           create: (context) => EditPerBasketBloc(
//         //         //               productRepository: productRepository,
//         //         //               inconsistencyBasketRepository:
//         //         //                   inconsistencyBasketRepository),
//         //         //           //phần trên là lấy lại inconsisRepository đã dùng ở EditBasket để gửi vô EditPerBasketBloc
//         //         //         ),
//         //         //         BlocProvider<EditBasketBloc>.value(
//         //         //           value: BlocProvider.of<EditBasketBloc>(
//         //         //               context), //lấy cái editBasketBloc trước đó để nạp vào screen tiếp theo
//         //         //         )
//         //         //       ],
//         //         //       child: EditPerBasketScreen(
//         //         //         isEditPeriodically: false,
//         //         //         inconsistencyBasket: inconsistencyBasket,
//         //         //       ),
//         //         //     )
//         //         ));
//       },
//     );
//   }
// }
