import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ielts/components/drawer/default_app_drawer.dart';
import 'package:ielts/utilities/constants/assets_path.dart';
import 'package:ielts/utilities/navigation/go_paths.dart';
import 'package:ielts/utilities/navigation/navigator.dart';

class DrawerData {
  final String key;
  final String value;
  final String route;
  final Function() onTap;

  DrawerData({
    required this.key,
    required this.value,
    required this.route,
    required this.onTap,
  });
}

class HiddenDrawerController extends GetxController {
  RxDouble xOffset = 0.0.obs;
  RxDouble yOffset = 0.0.obs;
  RxDouble scaleFactor = 1.0.obs;
  RxBool isDrawerOpen = false.obs;


  void toggleDrawer() {
    isDrawerOpen.value = !isDrawerOpen.value;
    if (isDrawerOpen.value) {
      xOffset.value = 230;
      yOffset.value = 130;
      scaleFactor.value = 0.7;
    } else {
      xOffset.value = 0;
      yOffset.value = 0;
      scaleFactor.value = 1;
    }
    debugPrint(isDrawerOpen.value.toString());
  }
}

class HiddenDrawerView extends StatefulWidget {
  const HiddenDrawerView({super.key});

  @override
  State<HiddenDrawerView> createState() => _HiddenDrawerViewState();
}

class _HiddenDrawerViewState extends State<HiddenDrawerView> {
  final _hiddenDrawerController = Get.put(HiddenDrawerController());

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  final Color _zircon = const Color(0xFFF4F7FE);
  final scienceBlue = const Color(0xFF066AC9);
  final heather = const Color(0xFFBCC1CD);
  final _toryBlue = const Color(0xff1A51AA);

  final userImage =
      "https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D";
  final drawer = List.generate(6, (index) {
    return DrawerData(
      key: AssetPath.dashboard,
      value: "title ${index + 1}",
      route: "/$index",
      onTap: () {
        debugPrint("title $index tapped");
      },
    );
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: _toryBlue,
            ),
            padding: const EdgeInsets.only(top: 50, bottom: 70, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.14),
                Column(
                  children: List.generate(
                    drawer.length,
                    (index) {
                      final drawerData = drawer[index];
                      return GestureDetector(
                        onTap: drawerData.onTap,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                          child: Row(
                            children: [
                              SvgPicture.asset(drawerData.key),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                drawerData.value,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Spacer(),
                const SizedBox(height: 30),
                SizedBox(
                  width: 190,
                  child: Divider(
                    height: 0.5,
                    color: heather,
                    thickness: 1.5,
                    indent: 10,
                    endIndent: 10,
                  ),
                ),
                Row(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "DSR",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            "email@example.com",
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 190,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      debugPrint("logout button has been tapped ");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AssetPath.logOut),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'Log out ',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: scienceBlue,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Obx(
            () => GestureDetector(
              onTap: () {
                if (_hiddenDrawerController.isDrawerOpen.value == false) {
                  return;
                }
                _hiddenDrawerController.toggleDrawer();
              },
              child: AnimatedContainer(
                transform: Matrix4.translationValues(
                  _hiddenDrawerController.xOffset.value,
                  _hiddenDrawerController.yOffset.value,
                  0,
                )..scale(
                    _hiddenDrawerController.scaleFactor.value,
                  ),
                duration: const Duration(
                  milliseconds: 250,
                ),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: _zircon,
                  borderRadius: BorderRadius.circular(_hiddenDrawerController.isDrawerOpen.value ? 40 : 0.0),
                  boxShadow: _hiddenDrawerController.isDrawerOpen.value
                      ? [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 24,
                          ),
                        ]
                      : [],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(_hiddenDrawerController.isDrawerOpen.value ? 24 : 0.0),
                  child: IgnorePointer(
                    ignoring: _hiddenDrawerController.isDrawerOpen.value,
                    child: Scaffold(
                      backgroundColor: _zircon,
                      appBar: AppBar(
                        title: Text(
                          "Hidden Drawer",
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                        ),
                        backgroundColor: _zircon,
                        elevation: 0,
                        leading: GestureDetector(
                          onTap: () {
                            _hiddenDrawerController.toggleDrawer();
                            // _hiddenDrawerController.scaffoldKey.currentState?.openDrawer();
                          },
                          child: const Icon(
                            Icons.menu,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                      drawer: DefaultCustomDrawer(
                        profile: () {
                          MyNavigator.pushNamed(GoPaths.profile);
                        },
                        onTapAbout: () {},
                      ),
                      body: Center(
                        child: Text(
                          "Hidden Drawer Example",
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
