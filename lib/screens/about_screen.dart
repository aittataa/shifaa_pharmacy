import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:provider/provider.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/provider/settings_provider.dart';
import 'package:shifaa_pharmacy/widget/back_icon.dart';
import 'package:shifaa_pharmacy/widget/container_details.dart';
import 'package:shifaa_pharmacy/widget/list_tile_details.dart';

class AboutScreen extends StatelessWidget {
  static const String id = "AboutScreen";
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) {
        settingsProvider.loadSettings;
        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            title: Text("About Us", style: TextStyle(fontWeight: FontWeight.bold)),
            leading: BackIconButton(),
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 5),
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
                        image: AssetImage("icons/icon_round.png"),
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
                        "$appTitle",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                        "$appDesc",
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
              ContainerDetails(
                icon: CupertinoIcons.heart_fill,
                text: "Rate App",
                onTap: () {
                  print("Rate App");
                },
              ),
              ContainerDetails(
                icon: Icons.share,
                text: "Share App",
                onTap: () {
                  shareApp(context, settings: appSettings);
                },
              ),
              ContainerDetails(
                icon: CupertinoIcons.folder_fill,
                text: "Privacy Policy",
                onTap: () {
                  print("Privacy Policy");
                },
              ),
              Container(
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: EdgeInsets.only(top: 5, bottom: 2.5),
                padding: EdgeInsets.all(10),
                child: Text(
                  "About Us",
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
                    launchURL("mailto: $email");
                  },
                ),
              if (appSettings.website != null)
                ListTileDetails(
                  icon: Icons.language,
                  text: "${appSettings.website}",
                  onTap: () {
                    String website = appSettings.website.toString();
                    launchURL("https://$website");
                  },
                ),
              if (appSettings.contact != null)
                ListTileDetails(
                  icon: CupertinoIcons.phone_fill,
                  text: "${appSettings.contact}",
                  onTap: () {
                    String contact = appSettings.contact.toString();
                    launchURL("tel: $contact");
                  },
                ),
              if (appSettings.address != null)
                ListTileDetails(
                  icon: CupertinoIcons.location_solid,
                  text: "${appSettings.address}",
                ),
              if (appSettings.description != null)
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                  child: Column(
                    children: [
                      Text(
                        "About App",
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
          ),
        );
      },
    );
  }
}
