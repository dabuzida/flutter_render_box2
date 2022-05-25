import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RenderBox',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('RenderBox'),
          elevation: 0,
          foregroundColor: Colors.cyanAccent,
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        backgroundColor: Colors.greenAccent[100],
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
  String? ownName;
  String? bogunsoName;
  ScrollController _scrollController = ScrollController();

  int _id = 0;
  bool _leftTap = true;
  bool _centerTap = false;
  bool _rightTap = false;
  late Color _menuTapTxColor; // text
  late Color _menuTapBgColor; // background
  late Color _menuTapBdColor; // border
  late double _mainContentHeight;

  final double _blankRow1 = 1;
  final double _blankRow10 = 10;
  final double _blankRow14 = 14;
  final double _blankRow15 = 15;

  final Color _tapPhraseColor = Color.fromARGB(255, 0, 71, 255);

  final Color _activeColor = const Color.fromARGB(255, 243, 245, 247);
  final Color _inactiveColor = const Color.fromARGB(255, 255, 255, 255);
  final Color _borderColor = const Color.fromARGB(255, 220, 226, 228);

  final GlobalKey _widgetKey = GlobalKey();

  @override
  void initState() {
    print('initState');
    super.initState();
    _changeMenuTap(state: 'normal'); // normal, hover, active
    _mainContentHeight = 1000;
  }

  final List _tapItems = [
    {
      'order': '01           ',
      'title': '고객 추가',
      'desc': '알츠윈 서비스를 받으실 고객을 추가하는 과정입니다',
      'img': [
        'how_to_use_manager_1_1.png',
        'how_to_use_manager_1_2.png',
      ],
    },
    {
      'order': '02           ',
      'title': '새 캠페인',
      'desc': '진행될 알츠윈 서비스의 고객과 일정을 설정합니다',
      'img': [
        'how_to_use_manager_2_1.png',
        'how_to_use_manager_2_2.png',
        'how_to_use_manager_2_3.png',
      ],
    },
    {
      'order': '03           ',
      'title': '알츠윈 콜',
      'desc': '고객에게 알츠윈 서비스 검사를 진행합니다',
      'img': [
        'how_to_use_manager_3_1.png',
        'how_to_use_manager_3_2.png',
      ],
    },
  ];

  final _menuTap = {
    'normal': {
      'txColor': Color(0xFF0047FF),
      'bgColor': Color.fromARGB(255, 182, 25, 25),
      'bdColor': Color.fromARGB(255, 22, 167, 22),
    },
    'hover': {
      'txColor': Color.fromARGB(255, 204, 31, 118),
      'bgColor': Color.fromARGB(255, 14, 137, 146),
      'bdColor': Color.fromARGB(255, 25, 25, 26),
    },
    'active': {
      'txColor': Color(0xFFFFFFFF),
      'bgColor': Color.fromARGB(255, 25, 139, 35),
      'bdColor': Color.fromARGB(255, 153, 29, 29),
    },
  };
  double _getWidgetHeight() {
    print('_getWidgetHeight');
    final RenderBox renderBox = _widgetKey.currentContext?.findRenderObject() as RenderBox;

    final Size size = renderBox.size;
    // print(size.width);
    print('위젯의 높이: ${size.height}');
    return size.height;
  }

  void _setVisibleTap({required int setTapId, required bool leftTap, required bool centerTap, required bool rightTap}) {
    print('_setVisibleTap');
    _id = setTapId;
    _leftTap = leftTap;
    _centerTap = centerTap;
    _rightTap = rightTap;
  }

  void _changeMenuTap({required String state}) {
    print('_changeMenuTap');
    // 메뉴버튼 평상시normal, 호버시hover, 클릭시active
    _menuTapTxColor = _menuTap[state]!['txColor']!;
    _menuTapBgColor = _menuTap[state]!['bgColor']!;
    _menuTapBdColor = _menuTap[state]!['bdColor']!;
  }

  void _onTapped({required int index}) {
    print('_onTapped');
    setState(() {
      if (index == 0) {
        _mainContentHeight = _getWidgetHeight();
        _setVisibleTap(setTapId: index, leftTap: true, centerTap: false, rightTap: false);
        _changeMenuTap(state: 'normal');
      } else if (index == 1) {
        _mainContentHeight = _getWidgetHeight();
        _setVisibleTap(setTapId: index, leftTap: false, centerTap: true, rightTap: false);
        _changeMenuTap(state: 'normal');
      } else if (index == 2) {
        _mainContentHeight = _getWidgetHeight();
        _setVisibleTap(setTapId: index, leftTap: false, centerTap: false, rightTap: true);
        _changeMenuTap(state: 'normal');
      } else if (index == 3) {
        _mainContentHeight = _getWidgetHeight();
        _setVisibleTap(setTapId: index, leftTap: false, centerTap: false, rightTap: false);
      }
    });
  }

  void _enterMenuTap(PointerEvent details) {
    print('_enterMenuTap');
    setState(() {
      _changeMenuTap(state: 'hover');
    });
  }

  void _exitMenuTap(PointerEvent details) {
    print('_exitMenuTap');
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
    print('build');
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
    print('buildUIGuide');
    return Container(
      width: 1700,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.amber, width: 2),
      ),
      margin: EdgeInsets.only(bottom: 100),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // TextXL(text: '알츠윈 관리자 사용 순서', color: Preset.colorDarkFont.value, fontWeight: FontWeight.w500),
          Text('알츠윈 관리자 사용 순서'),
          // const BlankColSM(),
          Container(
            width: double.infinity,
            // height: _mainContentHeight,
            height: MediaQuery.of(context).size.height,
            // height: 2000, // renderBox, key 로 구한 값으로 변경시킬 값
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purple, width: 2),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  // 배경 탭 3개
                  left: 0,
                  top: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        // border: Border.all(color: Colors.red, width: 1),
                        ),
                    height: 61,
                    // color: Colors.blueGrey[100],
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: <Widget>[
                              Expanded(child: _lowerTap(id: 0)),
                              // const SizedBox(width: 10),
                              SizedBox(width: _blankRow10),
                              Expanded(child: _lowerTap(id: 1)),
                              // const SizedBox(width: 10),
                              SizedBox(width: _blankRow10),
                              Expanded(child: _lowerTap(id: 2)),
                            ],
                          ),
                        ),
                        const Expanded(flex: 1, child: SizedBox()),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  // 메뉴 소개 탭
                  left: 0,
                  top: 0,
                  right: 0,
                  child: Row(
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
                            onTap: () => _onTapped(index: 3), // 0~2: 왼쪽 3개탭, 3: 오른쪽 메뉴 소개 탭
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
                                decoration: BoxDecoration(
                                  // border: Border.all(color: Colors.red, width: 1),
                                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                                ),
                                child: FittedBox(
                                  child: Text('메뉴 소개'),
                                  // child: TextM(text: '메뉴 소개', color: _menuTapTxColor, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  // 본문
                  left: 0,
                  top: 60,
                  right: 0,
                  child: Container(
                    // key: _widgetKey,
                    decoration: BoxDecoration(
                      color: _activeColor,
                      border: Border.all(color: _borderColor, width: 1),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    child: _buildMainContent(id: _id),
                  ),
                ),
                Positioned(
                  // 선택된 탭 3개
                  left: 0,
                  top: 1,
                  right: 0,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: <Widget>[
                            // const SizedBox(width: 1),
                            SizedBox(width: _blankRow1),
                            Expanded(
                              child: _upperTap(id: 0, visible: _leftTap),
                            ),
                            // const SizedBox(width: 12),
                            // const BlankRowSM(),
                            Expanded(
                              child: _upperTap(id: 1, visible: _centerTap),
                            ),
                            // const SizedBox(width: 12),
                            // const BlankRowSM(),
                            Expanded(
                              child: _upperTap(id: 2, visible: _rightTap),
                            ),
                            // const SizedBox(width: 1),
                            SizedBox(width: _blankRow1),
                          ],
                        ),
                      ),
                      const Expanded(flex: 1, child: SizedBox()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent({required int id}) {
    print('_buildMainContent');
    List<Widget> widgets = [];
    // widgets.add(const BlankColL());
    widgets.add(SizedBox(height: 25, child: Text(_tapItems[id]['desc'])));
    // widgets.add(const BlankColML());
    for (int i = 0; i < _tapItems[id]['img'].length; i++) {
      widgets.add(Image.asset('images/${_tapItems[id]['img'][i]}'));
      // widgets.add(const BlankColM());
    }
    return Container(
      key: _widgetKey,
      padding: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
          // border: Border.all(color: Colors.red, width: 1),
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      ),
    );
  }

  Widget _lowerTap({required int id}) {
    print('_lowerTap');
    return Container(
      // width: 130,
      height: 61,
      padding: const EdgeInsets.only(top: 10, right: 15, bottom: 10),
      decoration: BoxDecoration(
        color: _inactiveColor,
        border: Border.all(color: _borderColor, width: 1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 15,
            child: SizedBox(width: _blankRow15),
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
    print('_upperTap');
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
              borderRadius: BorderRadius.only(
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
