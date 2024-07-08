import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ielts/utilities/constants/assets_path.dart';
import 'package:ielts/utilities/constants/cached_image_network_container.dart';
import 'package:ielts/utilities/constants/common_model.dart';
import 'package:ielts/utilities/theme/app_box_decoration.dart';
import 'package:ielts/utilities/theme/app_colors.dart';
import 'package:ielts/utilities/theme/button_decoration.dart';

typedef VoidCallback = void Function();

class DefaultCustomDrawer extends StatefulWidget {
  final VoidCallback profile;
  final VoidCallback onTapAbout;

  const DefaultCustomDrawer({
    Key? key,
    required this.profile,
    required this.onTapAbout,
  }) : super(key: key);

  @override
  State<DefaultCustomDrawer> createState() => _DefaultCustomDrawerState();
}

class _DefaultCustomDrawerState extends State<DefaultCustomDrawer> {
  int selectedIndex = -1;
  bool isLoggedOut = false;
  final String userImage =
      "https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";

  final drawerData = [
    KeyValuePair(
      key: "Country",
      value: [
        KeyValuePair(key: "UK", value: "", path: AssetPath.uk),
        KeyValuePair(key: "USA", value: "", path: AssetPath.usa),
        KeyValuePair(key: "Australia", value: "", path: AssetPath.australia),
        KeyValuePair(key: "Canada", value: "", path: AssetPath.canada),
        KeyValuePair(key: "Germany", value: "", path: AssetPath.germany),
      ],
      path: AssetPath.country,
    ),
    KeyValuePair(
      key: "Services",
      value: [
        KeyValuePair(key: "admission consultancy", value: "", path: AssetPath.admissionConsultancy),
        KeyValuePair(key: "language preparation", value: "", path: AssetPath.testPreparation),
        KeyValuePair(key: "visa assistance", value: "", path: AssetPath.visaAssistance),
        KeyValuePair(key: "finance", value: "", path: AssetPath.finance),
        KeyValuePair(key: "accommodation", value: "", path: AssetPath.accommodation),
        KeyValuePair(key: "document preparation", value: "", path: AssetPath.documentPreparation),
      ],
      path: AssetPath.services,
    ),
  ];

  void _toggleDropdown(int index) {
    setState(() {
      if (index == selectedIndex) {
        selectedIndex = -1;
        return;
      }
      selectedIndex = index;
    });
  }

  _image({String? image}) {
    if (image?.contains(".png") == true) {
      return Image.asset(
        image!,
        height: 24,
        width: 24,
      );
    }
    if (image?.contains(".svg") == true) {
      return SvgPicture.asset(
        height: 24,
        width: 24,
        image!,
        semanticsLabel: 'Custom Image',
      );
    }
    return const SizedBox();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 22),
            child: SvgPicture.asset(AssetPath.appLogo),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                minimumSize: Size(MediaQuery.of(context).size.width, 48),
              ),
              onPressed: () {
                debugPrint("here is the elevated button tapped");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.call, color: AppColors.white),
                  const SizedBox(width: 12),
                  Text(
                    "Book a session ",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          letterSpacing: 0.15,
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
            child: Text(
              "Menu",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.blueGrey,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          ...List.generate(drawerData.length, (index) {
            final item = drawerData[index];

            return GestureDetector(
              onTap: () {
                _toggleDropdown(index);
              },
              child: AnimatedContainer(
                decoration: AppBoxDecoration.getBoxDecoration(
                  showShadow: false,
                  borderRadius: 12,
                  color: selectedIndex == index ? AppColors.zircon : AppColors.white,
                ),
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                duration: const Duration(milliseconds: 600),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: selectedIndex == index ? 16 : 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              _image(image: item.path),
                              const SizedBox(width: 8),
                              Text(
                                item.key,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          AnimatedRotation(
                            turns: selectedIndex == index ? 0 : 0.5,
                            duration: const Duration(milliseconds: 400),
                            child: const Icon(Icons.keyboard_arrow_up),
                          )
                        ],
                      ),
                    ),
                    AnimatedCrossFade(
                      firstChild: Container(),
                      secondChild: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: AppBoxDecoration.getBoxDecoration(
                              showShadow: false,
                            ),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              ...List.generate(
                                item.value.length,
                                (index) {
                                  final subItem = item.value[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        _image(image: subItem.path),
                                        const SizedBox(width: 12),
                                        Text(
                                          subItem.key,
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                color: AppColors.deepSapphire,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              if (item.key == "Country") ...[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                                  child: OutlinedButton(
                                    style: getOutlinedButtonStyle(
                                      showShadow: false,
                                      borderRadius: 12,
                                      borderColor: Colors.transparent,
                                      backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                                    ),
                                    onPressed: widget.onTapAbout,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "More",
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                color: AppColors.primaryColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        const SizedBox(width: 4),
                                        const Icon(Icons.arrow_forward, color: AppColors.primaryColor, size: 18)
                                      ],
                                    ),
                                  ),
                                )
                              ]
                            ]),
                          ),
                        ],
                      ),
                      crossFadeState: selectedIndex == index ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 200),
                    ),
                  ],
                ),
              ),
            );
          }),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            decoration: AppBoxDecoration.getBoxDecoration(
              showShadow: false,
              color: Colors.white,
            ),
            child: Row(
              children: [
                _image(image: AssetPath.blogs),
                const SizedBox(width: 8),
                Text("blogs", style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Divider(
            height: 1,
            endIndent: 20,
            indent: 20,
            color: AppColors.iron,
            thickness: 0,
          ),
          GestureDetector(
            onTap: widget.profile,
            child: Container(
                margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
                decoration: AppBoxDecoration.getBoxDecoration(
                  showShadow: false,
                  color: Colors.transparent,
                ),
                child: Row(
                  children: [
                    CachedImageNetworkContainer(
                      height: 44,
                      width: 44,
                      fit: BoxFit.contain,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      url: userImage,
                      placeHolder: buildPlaceholder(
                        name: "name",
                        context: context,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "DSR",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.mirage),
                        ),
                        Text(
                          "hellowdsr@example.com",
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppColors.gullGrey,
                              ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: OutlinedButton(
              style: getOutlinedButtonStyle(
                  showShadow: false,
                  borderRadius: 12,
                  borderColor: Colors.transparent,
                  foregroundColor: AppColors.white,
                  backgroundColor: AppColors.desertStorm),
              onPressed: () async {
                debugPrint("logout button has been tapped");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AssetPath.logout),
                  const SizedBox(width: 8),
                  Text(
                    "Logout",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          letterSpacing: 0.15,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
