import 'package:flutter/material.dart';
import 'package:flutter_whatsapp_app/views/helper/GoogleADHelper.dart';
import 'package:flutter_whatsapp_app/views/utils/ColorUtils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> FormKey = GlobalKey<FormState>();

  TextEditingController MessageController = TextEditingController();

  TextEditingController NumberController = TextEditingController();
  int? numberSaved;

  @override
  void initState() {
    MessageController = TextEditingController();
    NumberController = TextEditingController();
    GoogleAdsHelper.googleAdsHelper.showBannerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WhatsApp Direct Chat",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: WhiteText,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: GreyColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(
          h * 0.025,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 9,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: FormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Number",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                color: WhiteText,
                                fontWeight: FontWeight.bold,
                                fontSize: h * 0.022,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: h * 0.01,
                          ),
                          TextFormField(
                            controller: NumberController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter Valid Phone Number...";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              numberSaved = int.parse(val!);
                            },
                            cursorColor: WhiteText,
                            style: TextStyle(
                              fontSize: h * 0.02,
                              color: WhiteText,
                              fontWeight: FontWeight.bold,
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  h * 0.01,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(h * 0.01),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: LightGreen,
                                ),
                                borderRadius: BorderRadius.circular(
                                  h * 0.01,
                                ),
                              ),
                              hintText: "Enter Phone Number",
                              hintStyle: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: h * 0.02,
                                  color: WhiteText,
                                ),
                              ),
                              filled: true,
                              fillColor: GreyColor,
                            ),
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Text(
                            "Message",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                color: WhiteText,
                                fontWeight: FontWeight.bold,
                                fontSize: h * 0.022,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: h * 0.01,
                          ),
                          TextFormField(
                            controller: MessageController,
                            onSaved: (val) {
                              MessageController.text = val!;
                            },
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter Valid Message Here...";
                              }
                              return null;
                            },
                            cursorColor: WhiteText,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (val) {
                              if (FormKey.currentState!.validate()) {
                                FormKey.currentState!.save();
                              }
                            },
                            style: TextStyle(
                              fontSize: h * 0.02,
                              color: WhiteText,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  h * 0.01,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(h * 0.01),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: LightGreen,
                                ),
                                borderRadius: BorderRadius.circular(
                                  h * 0.01,
                                ),
                              ),
                              hintText: "Enter Messages",
                              hintStyle: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: h * 0.02,
                                  color: WhiteText,
                                ),
                              ),
                              filled: true,
                              fillColor: GreyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: h * 0.04,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (FormKey.currentState!.validate()) {
                          final phoneNumber = '+91${NumberController.text}';
                          final message = MessageController.text;
                          final link = WhatsAppUnilink(
                            phoneNumber: phoneNumber,
                            text: message,
                          );
                          await launchUrlString('$link');
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: DarkGreen,
                          borderRadius: BorderRadius.circular(h * 0.01),
                        ),
                        alignment: Alignment.center,
                        height: h * 0.06,
                        width: w,
                        child: Text(
                          'SEND',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              fontSize: h * 0.02,
                              color: WhiteText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  "Manage By : HR DigiTech🇮🇳",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: h * 0.016,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: h * 0.06,
        child: AdWidget(
          ad: GoogleAdsHelper.googleAdsHelper.bannerAd!,
        ),
      ),
      backgroundColor: LightBGColor,
    );
  }

  @override
  void dispose() {
    NumberController.clear();
    MessageController.clear();
    super.dispose();
  }
}
