import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void showLayoutGuidelines() {
  debugPaintSizeEnabled = true;
}

void main() {
  // showLayoutGuidelines();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RenderBox2',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('RenderBox2'),
          elevation: 0,
          foregroundColor: Colors.cyanAccent,
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: HomeScreen(),
        // body: AAA(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  late int _id;
  late bool _leftTap;
  late bool _centerTap;
  late bool _rightTap;
  late Color _menuTapTxColor; // text
  late Color _menuTapBgColor; // background
  late Color _menuTapBdColor; // border
  // double _mainContentHeight = 1000;

  final Color _tapPhraseColor = Color.fromARGB(255, 0, 71, 255);

  final Color _activeColor = const Color.fromARGB(255, 243, 245, 247);
  final Color _inactiveColor = const Color.fromARGB(255, 255, 255, 255);
  final Color _borderColor = const Color.fromARGB(255, 220, 226, 228);

  final List _tapItems = [
    {
      'order': '01           ',
      'title': '고객 추가',
      'desc': '알츠윈 서비스를 받으실 고객을 추가하는 과정입니다',
      'img': [
        'dev01.jpg',
        'dev02.jpg',
      ],
    },
    {
      'order': '02           ',
      'title': '새 캠페인',
      'desc': '진행될 알츠윈 서비스의 고객과 일정을 설정합니다',
      'img': [
        'dev03.jpg',
        'dev04.jpg',
        'dev05.jpg',
      ],
    },
    {
      'order': '03           ',
      'title': '알츠윈 콜',
      'desc': '고객에게 알츠윈 서비스 검사를 진행합니다',
      'img': [
        'dev06.jpg',
        'dev07.jpg',
      ],
    },
  ];

  final _menuTapDeco = {
    'normal': {
      'txColor': const Color(0xFF0047FF),
      'bgColor': const Color.fromARGB(255, 182, 25, 25),
      'bdColor': const Color.fromARGB(255, 22, 167, 22),
    },
    'hover': {
      'txColor': const Color.fromARGB(255, 204, 31, 118),
      'bgColor': const Color.fromARGB(255, 14, 137, 146),
      'bdColor': const Color.fromARGB(255, 25, 25, 26),
    },
    'active': {
      'txColor': const Color(0xFFFFFFFF),
      'bgColor': const Color.fromARGB(255, 25, 139, 35),
      'bdColor': const Color.fromARGB(255, 153, 29, 29),
    },
  };

  @override
  void initState() {
    super.initState();
    _setVisibleTap(id: 0, leftTap: true, centerTap: false, rightTap: false);
    _changeMenuTap(state: 'normal'); // normal, hover, active
  }

  void _setVisibleTap({required int id, required bool leftTap, required bool centerTap, required bool rightTap}) {
    _id = id;
    _leftTap = leftTap;
    _centerTap = centerTap;
    _rightTap = rightTap;
  }

  void _changeMenuTap({required String state}) {
    // 메뉴버튼 평상시normal, 호버시hover, 클릭시active
    _menuTapTxColor = _menuTapDeco[state]!['txColor']!;
    _menuTapBgColor = _menuTapDeco[state]!['bgColor']!;
    _menuTapBdColor = _menuTapDeco[state]!['bdColor']!;
  }

  void _onTapped({required int index}) {
    setState(() {
      if (index == 0) {
        _setVisibleTap(id: index, leftTap: true, centerTap: false, rightTap: false);
        _changeMenuTap(state: 'normal');
      } else if (index == 1) {
        _setVisibleTap(id: index, leftTap: false, centerTap: true, rightTap: false);
        _changeMenuTap(state: 'normal');
      } else if (index == 2) {
        _setVisibleTap(id: index, leftTap: false, centerTap: false, rightTap: true);
        _changeMenuTap(state: 'normal');
      } else if (index == 3) {
        _setVisibleTap(id: index, leftTap: false, centerTap: false, rightTap: false);
      }
    });
  }

  void _enterMenuTap(PointerEvent details) {
    setState(() {
      _changeMenuTap(state: 'hover');
    });
  }

  void _exitMenuTap(PointerEvent details) {
    setState(() {
      if (0 <= _id && _id <= 2) {
        _changeMenuTap(state: 'normal');
      } else if (_id == 3) {
        _changeMenuTap(state: 'active');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: _scrollController,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const BlankColL(),
            // const BlankColL(),
            _buildUIGuide(),
          ],
        ),
      ],
    );
  }

  Widget _buildUIGuide() {
    return Container(
      width: 1700,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.amber, width: 2),
      ),
      margin: const EdgeInsets.only(bottom: 50),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // TextXL(text: '알츠윈 관리자 사용 순서', color: Preset.colorDarkFont.value, fontWeight: FontWeight.w500),
          const Text('알츠윈 관리자 사용 순서'),
          // const BlankColSM(),
          Container(
            width: double.infinity,
            // height: MediaQuery.of(context).size.height,
            // height: 2000, // renderBox, key 로 구한 값으로 변경시킬 값
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purple, width: 2),
            ),
            child: Stack(
              children: <Widget>[
                Column(
                  // 배경 탭 3개
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                          // border: Border.all(color: Colors.red, width: 1),
                          ),
                      height: 61,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: <Widget>[
                                Expanded(child: _lowerTap(id: 0)),
                                // const SizedBox(width: 10),
                                const SizedBox(width: 10),
                                Expanded(child: _lowerTap(id: 1)),
                                // const SizedBox(width: 10),
                                const SizedBox(width: 10),
                                Expanded(child: _lowerTap(id: 2)),
                              ],
                            ),
                          ),
                          const Expanded(flex: 1, child: SizedBox()),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  // 메뉴 소개 탭
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        const Expanded(flex: 667, child: SizedBox()),
                        Expanded(
                          flex: 130,
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: _enterMenuTap,
                            onExit: _exitMenuTap,
                            child: GestureDetector(
                              // onTap: () => _onTapped(index: 3), // 0~2: 왼쪽 3개탭, 3: 오른쪽 메뉴 소개 탭
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: _menuTapBgColor,
                                  border: Border.all(color: _menuTapBdColor, width: 1),
                                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                                ),
                                child: Container(
                                  // width: double.infinity,
                                  height: 16,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    // border: Border.all(color: Colors.red, width: 1),
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                  child: FittedBox(
                                    child: Text('메뉴 소개', style: TextStyle(color: _menuTapTxColor)),
                                    // child: TextM(text: '메뉴 소개', color: _menuTapTxColor, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  // 본문
                  children: <Widget>[
                    const SizedBox(height: 60),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: _activeColor,
                        border: Border.all(color: _borderColor, width: 1),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      child: _buildMainContent(id: _id),
                    ),
                  ],
                ),
                Column(
                  // 선택된 탭 3개
                  children: [
                    const SizedBox(height: 1),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: <Widget>[
                              // const SizedBox(width: 1),
                              const SizedBox(width: 1),
                              Expanded(
                                child: _upperTap(id: 0, visible: _leftTap),
                              ),
                              const SizedBox(width: 12),
                              // const BlankRowSM(),
                              Expanded(
                                child: _upperTap(id: 1, visible: _centerTap),
                              ),
                              const SizedBox(width: 12),
                              // const BlankRowSM(),
                              Expanded(
                                child: _upperTap(id: 2, visible: _rightTap),
                              ),
                              // const SizedBox(width: 1),
                              const SizedBox(width: 1),
                            ],
                          ),
                        ),
                        const Expanded(flex: 1, child: SizedBox()),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent({required int id}) {
    List<Widget> widgets = [];
    // widgets.add(const BlankColL());
    widgets.add(SizedBox(height: 25, child: Text(_tapItems[id]['desc'])));
    // widgets.add(const BlankColML());
    for (int i = 0; i < _tapItems[id]['img'].length; i++) {
      widgets.add(Image.asset('${_tapItems[id]['img'][i]}'));
      // widgets.add(const BlankColM());
    }
    return Container(
      // key: _widgetKey2,
      // key: _widgetKey,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      decoration: const BoxDecoration(
          // border: Border.all(color: Colors.red, width: 1),
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      ),
    );
  }

  Widget _lowerTap({required int id}) {
    return Container(
      // width: 130,
      height: 61,
      padding: const EdgeInsets.only(top: 10, right: 15, bottom: 10),
      decoration: BoxDecoration(
        color: _inactiveColor,
        border: Border.all(color: _borderColor, width: 1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      child: Row(
        children: <Widget>[
          const Expanded(
            flex: 15,
            child: SizedBox(width: 15),
          ),
          Expanded(
            flex: 115,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 17,
                  alignment: Alignment.topLeft,
                  child: FittedBox(
                    child: Text(_tapItems[id]['order']),
                    // child: TextL(text: _tapItems[id]['order'], color: Preset.colorDisablePressed.value),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 17,
                  alignment: Alignment.bottomLeft,
                  child: FittedBox(
                    child: Text(_tapItems[id]['title']),
                    // child: TextM(text: _tapItems[id]['title'], color: Preset.colorDisablePressed.value),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _upperTap({required int id, required bool visible}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _onTapped(index: id),
        child: Visibility(
          visible: visible,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          maintainInteractivity: true,
          child: Container(
            height: 60,
            padding: const EdgeInsets.only(top: 10, right: 15, bottom: 10),
            decoration: BoxDecoration(
              color: _activeColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 40,
                    color: _tapPhraseColor,
                  ),
                ),
                const Expanded(flex: 8, child: SizedBox()),
                Expanded(
                  flex: 115,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 17,
                        alignment: Alignment.topLeft,
                        child: FittedBox(
                          child: Text(_tapItems[id]['order']),
                          // child: TextL(text: _tapItems[id]['order'], color: Preset.colorPrimaryNormal.value, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 17,
                        alignment: Alignment.bottomLeft,
                        child: FittedBox(
                          child: Text(_tapItems[id]['title']),
                          // child: TextM(text: _tapItems[id]['title'], color: Preset.colorPrimaryNormal.value, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
