import 'dart:ui';

import 'package:flutter/material.dart';

//--------------  colors --------------

const _desertStorm = Color(0xFFF7F8F9);
const _iron = Color(0xFFD0D5DD);
const _mirage = Color(0xFF191D23);
const _gullGrey = Color(0xFFA0ABBB);
const _whiteSmoke = Color(0xFFF3F6F9);

const userImage =
    "https://images.unsplash.com/photo-1633332755192-727a05c4013d?"
    "w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3f"
    "DB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D";

class DrawerData {
  final String title;
  final String path;
  final IconData icon;

  DrawerData({
    required this.title,
    required this.path,
    required this.icon,
  });
}

typedef VoidCallback = void Function();

bool isFirstContainerTapped = false; // Track the tap on the first container

class CustomSideDrawer extends StatefulWidget {
  const CustomSideDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomSideDrawer> createState() => _CustomSideDrawerState();
}

class _CustomSideDrawerState extends State<CustomSideDrawer>
    with TickerProviderStateMixin {
  int selectedIndex = -1;
  bool isLoggedOut = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final menuItems = [
    DrawerData(
      title: "Dashboard",
      path: "/ieltsDashboard",
      icon: Icons.dashboard,
    ),
    DrawerData(
      title: "Recorded Videos",
      path: "/ieltsRecordedVideos",
      icon: Icons.video_call,
    ),
    DrawerData(
      title: "Mock Tests",
      path: "/ieltsMockTest",
      icon: Icons.telegram_sharp,
    ),
    DrawerData(
      title: "Practice Tests",
      path: "/ieltsPracticeTest",
      icon: Icons.terminal_sharp,
    ),
    DrawerData(
      title: "Study Materials",
      path: "/ieltsStudyMaterialScreen",
      icon: Icons.ac_unit,
    ),
    DrawerData(
      title: "Attendance",
      path: "/ieltsUserAttendance",
      icon: Icons.accessibility_new,
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  _toggle() {
    setState(() {
      isFirstContainerTapped = !isFirstContainerTapped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        extendBody: true,
        backgroundColor: _gullGrey,
        key: _scaffoldKey,
        body: const Center(
          child: FlutterLogo(
            style: FlutterLogoStyle.stacked,
            size: 200,
            duration: Duration(microseconds: 300),
            textColor: Colors.black,
          ),
        ),
      ),
      TapRegion(
        onTapInside: (event) {
          debugPrint(
              "-------------- onTapInside $isFirstContainerTapped-- _customFirstContainer");
          if (isFirstContainerTapped == false) {
            _toggle();
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          margin: const EdgeInsets.only(
            left: 12,
            top: 40,
            bottom: 20,
          ),
          width: MediaQuery.of(context).size.width * 0.22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white,
          ),
          curve: Curves.easeOutCirc,
          transform: isFirstContainerTapped
              ? Matrix4.translationValues(
                  MediaQuery.of(context).size.width * 0.10 - 12, 0, 0)
              : Matrix4.translationValues(0, 0, 0),
          child: _buildFirstContainer(context, menuItems),
        ),
      ),
      TapRegion(
        onTapInside: (event) {
          _toggle();
        },
        child: AnimatedOpacity(
          opacity: isFirstContainerTapped ? 1 : 0.0,
          duration: const Duration(microseconds: 400),
          curve: Curves.easeInOut,
          child: _buildSecondContainer(context, menuItems),
        ),
      ),
    ]);
  }
}

_buildFirstContainer(context, menuItems) {
  return Column(
    children: [
      SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlutterLogo(
                  size: 40,
                  duration: Duration(microseconds: 300),
                  textColor: Colors.black,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 12),
            ...List.generate(
              menuItems.length,
              (index) {
                final item = menuItems[index];
                return GestureDetector(
                  onTap: () async {},
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 18,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    child: Row(
                      children: [
                        Icon(item.icon),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      const Spacer(),
      Column(
        children: [
          const SizedBox(height: 12),
          const Divider(
            height: 1.5,
            endIndent: 20,
            indent: 20,
            color: _iron,
            thickness: 0,
          ),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.logout),
          ),
          const SizedBox(height: 16)
        ],
      )
    ],
  );
}

_buildSecondContainer(context, menuItems) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 400),
    curve: Curves.easeOutCirc,
    transform: isFirstContainerTapped
        ? Matrix4.translationValues(
            MediaQuery.of(context).size.width * 0.02 - 12, 0, 0)
        : Matrix4.translationValues(0, 0, 0),
    margin: EdgeInsets.only(
      left: 12,
      right: MediaQuery.of(context).size.width * 0.20,
      top: 40,
      bottom: 20,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      color: Colors.white,
    ),
    child: Column(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlutterLogo(
                    style: FlutterLogoStyle.horizontal,
                    size: 60,
                    duration: Duration(microseconds: 300),
                    textColor: Colors.black,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 12),
              ...List.generate(
                menuItems.length,
                (index) {
                  final item = menuItems[index];
                  return GestureDetector(
                    onTap: () async {},
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 18,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                      child: Row(
                        children: [
                          Icon(item.icon),
                          const SizedBox(width: 14),
                          Text(
                            item.title.toString(),
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const Spacer(),
        Column(
          children: [
            const SizedBox(height: 12),
            const Divider(
              height: 1.5,
              endIndent: 20,
              indent: 20,
              color: _iron,
              thickness: 0,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 26),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(userImage),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "DSR",
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: _mirage,
                                  ),
                        ),
                        Text(
                          "example@gmail.com",
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: _gullGrey,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: _whiteSmoke,
                    backgroundColor: _desertStorm,
                    elevation: 0),
                onPressed: () async {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Logout",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            letterSpacing: 0.15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16)
          ],
        )
      ],
    ),
  );
}
