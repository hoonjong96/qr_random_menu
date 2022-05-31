import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';

/** 2022.05.09 jongdroid
 *  [핵심 기능]
 *  qr을 스캔하여 data로 메뉴를 추출하며, 고정된 메뉴를 피하고자 list로 데이터를 담았습니다.
 */

/* [**내 실수**]
 *  setState 안에 절대로 함수가 들어가면 안돼 훈종아!! --> 변수만 들어갈 것
 */

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('QR이 추천하는 랜덤 메뉴 뽑기'),
          centerTitle: true,
        ),
        body: CreateQR(),
      ),
    );
  }
}

//큐알 스캔을 통해 랜덤으로 메뉴를 받을 수 있는 변수
var createRanNum = Random().nextInt(MenuList.length);

//QR 스캔 후 얻을 수 있는 메뉴 리스트
var MenuList = [
  '짜장면',
  '짬뽕',
  '볶음밥',
  '탕수육',
  '김치찌개',
  '삼겹살',
  '된장찌개',
  '찜닭',
  '순대국',
  '갈비탕',
  '부대찌개',
  '콩나물국밥'
];

// 랜덤으로 생성한 값을 통해 리스트 인덱스를 받아와 해당 변수에 저장하여 출력하는 변수
var QRPrintMenu = '${MenuList[createRanNum]}';

class CreateQR extends StatefulWidget {
  const CreateQR({Key? key}) : super(key: key);

  @override
  State<CreateQR> createState() => _CreateQRState();
}

class _CreateQRState extends State<CreateQR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Column(
                children: [
                  QrImage(
                    //스캔 시 전달하는 데이터
                    data: ('${QRPrintMenu} 추천드립니다!'),
                    backgroundColor: Colors.white,
                    size: 200,
                  ),
                  SizedBox(
                    child: ElevatedButton(
                      child: Icon(Icons.refresh),
                      onPressed: () {
                        ShowToast();
                        createRanNum = Random().nextInt(MenuList.length);
                        setState(() {
                          QRPrintMenu = '${MenuList[createRanNum]}';
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 버튼 클릭 Toast
void ShowToast() {
  Fluttertoast.showToast(
    msg: 'QR 코드를 스캔해보세요!',
    gravity: ToastGravity.TOP,
    backgroundColor: Colors.grey,
    fontSize: 20,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
  );
}