import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/classes/settings.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/constant/messages.dart';
import 'package:shifaa_pharmacy/constant/shared_functions.dart';
import 'package:shifaa_pharmacy/controllers/settings_controller.dart';
import 'package:shifaa_pharmacy/widget/back_icon.dart';
import 'package:shifaa_pharmacy/widget/horizontal_button.dart';
import 'package:shifaa_pharmacy/widget/list_tile_details.dart';

class AboutScreen extends StatelessWidget {
  static const String id = "AboutScreen";
  final SettingsController settingsController = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          Messages.ABOUT_SCREEN_TITLE,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: BackIconButton(),
      ),
      body: Obx(() {
        final Settings appSettings = settingsController.appSettings.value;
        return ListView(
          padding: EdgeInsets.all(10),
          physics: BouncingScrollPhysics(),
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: screenHeight * 0.25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(Messages.APP_ICON_ROUND),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    dense: true,
                    title: Text(
                      Messages.APP_TITLE,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      Messages.APP_DESC,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: HorizontalButton(
                      icon: CupertinoIcons.heart_fill,
                      title: Messages.RATE_APP,
                    ),
                  ),
                  Expanded(
                    child: HorizontalButton(
                      icon: Icons.share,
                      title: Messages.SHARE_APP,
                      onPressed: () => SharedFunctions.shareApp(context, settings: appSettings),
                    ),
                  ),
                  Expanded(
                    child: HorizontalButton(
                      icon: CupertinoIcons.folder_fill,
                      title: Messages.POLICY_APP,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                Messages.ABOUT_SCREEN_TITLE,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                ),
              ),
            ),
            if (appSettings.version != null)
              ListTileDetails(
                icon: Icons.info,
                text: "${appSettings.version}",
              ),
            if (appSettings.name != null)
              ListTileDetails(
                icon: CupertinoIcons.person_crop_circle,
                text: "${appSettings.name}",
              ),
            if (appSettings.email != null)
              ListTileDetails(
                icon: CupertinoIcons.mail_solid,
                text: "${appSettings.email}",
                onTap: () {
                  String email = appSettings.email.toString();
                  SharedFunctions.launchURL("mailto: $email");
                },
              ),
            if (appSettings.website != null)
              ListTileDetails(
                icon: Icons.language,
                text: "${appSettings.website}",
                onTap: () {
                  String website = appSettings.website.toString();
                  SharedFunctions.launchURL("https://$website");
                },
              ),
            if (appSettings.contact != null)
              ListTileDetails(
                icon: CupertinoIcons.phone_fill,
                text: "${appSettings.contact}",
                onTap: () {
                  String contact = appSettings.contact.toString();
                  SharedFunctions.launchURL("tel: $contact");
                },
              ),
            if (appSettings.address != null)
              ListTileDetails(
                icon: CupertinoIcons.location_solid,
                text: "${appSettings.address}",
              ),
            if (appSettings.description != null)
              Container(
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                child: Column(
                  children: [
                    Text(
                      Messages.ABOUT_APP,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Html(
                      data: "${appSettings.description}",
                      style: {
                        "body": Style(
                          fontSize: FontSize(12),
                          fontWeight: FontWeight.bold,
                        )
                      },
                    ),
                  ],
                ),
              ),
          ],
        );
      }),
    );
  }
}
