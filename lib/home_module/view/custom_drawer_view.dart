import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ielts/utilities/constants/common_model.dart';

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

class DefaultCustomDrawer extends StatefulWidget {
  const DefaultCustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<DefaultCustomDrawer> createState() => _DefaultCustomDrawerState();
}

class _DefaultCustomDrawerState extends State<DefaultCustomDrawer>
    with TickerProviderStateMixin {
  int selectedIndex = -1;
  bool isLoggedOut = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final userImage =
      "https://images.unsplash.com/photo-1633332755192-727a05c4013d?"
      "w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3f"
      "DB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D";

  //--------------  colors --------------
  final _desertStorm = const Color(0xFFF7F8F9);
  final _iron = const Color(0xFFD0D5DD);
  final _mirage = const Color(0xFF191D23);
  final _gullGrey = const Color(0xFFA0ABBB);
  final _whiteSmoke = const Color(0xFFF3F6F9);









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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _gullGrey,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Drawer Example ",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        child: TapRegion(
          onTapOutside: (event) {
            _scaffoldKey.currentState?.closeDrawer();
          },
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                margin: EdgeInsets.only(
                  left: 12,
                  right: MediaQuery.of(context).size.width * 0.24,
                  top: 40,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
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
                                size: 90,
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
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
                        Divider(
                          height: 1.5,
                          endIndent: 20,
                          indent: 20,
                          color: _iron,
                          thickness: 0,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 26),
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: _mirage,
                                          ),
                                    ),
                                    Text(
                                      "example@gmail.com",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
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
                            onPressed: () async {
                              setState(() {
                                isLoggedOut = !isLoggedOut;
                              });
                              Future.delayed(const Duration(seconds: 3), () {
                                setState(() {
                                  isLoggedOut = !isLoggedOut;
                                });
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (isLoggedOut == false) ...[
                                  const Icon(
                                    Icons.logout,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ],
                                const SizedBox(width: 8),
                                isLoggedOut
                                    ? const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(),
                                      )
                                    : Text(
                                        "Logout",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
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
              )),
        ),
      ),
      body: const Center(
        child: FlutterLogo(
          style: FlutterLogoStyle.stacked,
          size: 200,
          duration: Duration(microseconds: 300),
          textColor: Colors.black,
        ),
      ),
    );
  }
}
