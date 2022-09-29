import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Components/Utilities/CommonFunc.dart';
import 'VerifyCodeVC.dart';


class TermsAndConditions extends StatelessWidget {

  final String phoneNumber;
  const TermsAndConditions({required this.phoneNumber, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(10),
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(
          top: 10.0,
        ),
        margin: EdgeInsets.only(top: height * .1, right: 8.0, left: 8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
                blurRadius: 0.0,
                offset: Offset(0.0, 0.0),
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Terms & Conditions",
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          letterSpacing: 1,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Divider(
                      color: Colors.grey[200],
                    ),
                  ),
                  Container(
                    height: height * .7,
                    child: const SingleChildScrollView(
                      child: Text(
                        "GeeksForGeeks is a good platform to learn programming."
                            " It is an educational website.GeeksForGeeks is a good platform to learn programming."
                            " It is an educational website.GeeksForGeeks is a good platform to learn programming."
                            " It is an educational website.GeeksForGeeks is a good platform to learn programming."
                            " It is an educational website.GeeksForGeeks is a good platform to learn programming."
                            " It is an educational website.GeeksForGeeks is a good platform to learn programming."
                            " It is an educational website.GeeksForGeeks is a good platform to learn programming."
                            " It is an educational website.GeeksForGeeks is a good platform to learn programming."
                            " It is an educational website.GeeksForGeeks is a good platform to learn programming."
                            " It is an educational website.GeeksForGeeks is a good platform to learn programming."
                            " It is an educational website.GeeksForGeeks is a good platform to learn programming."
                            " It is an educational website.GeeksForGeeks is a good platform to learn programming."
                            " It is an educational website.GeeksForGeeks is a good platform to learn programming."
                            " It is an educational website.GeeksForGeeks is a good platform to learn programming."
                            " It is an educational website.GeeksForGeeks is a good platform to learn programming."
                            " It is an educational website.",
                        style: TextStyle(
                          fontSize: 14.0,
                          letterSpacing: 2,
                          wordSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.blue, //<-- SEE HERE
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(createRoute(VerifyCodeVC(phoneNumber:phoneNumber)));
                          },
                          child: const Text(
                            'Accept and Continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              letterSpacing: 2,
                              wordSpacing: 2,
                            ),
                          )),
                      //TextButton(onPressed: (){}, child: Text('Close'))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );

    // return Stack(
    //
    //   alignment: Alignment.center,
    //   children: <Widget>[
    //     Container(
    //       width: double.infinity,
    //       height: 200,
    //       decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(15),
    //           color: Colors.lightBlue
    //       ),
    //       padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
    //       child: Text("You can make cool stuff!",
    //           style: TextStyle(fontSize: 24),
    //           textAlign: TextAlign.center
    //       ),
    //     ),
    //     Positioned(
    //         top: -100,
    //         child: Image.network("https://i.imgur.com/2yaf2wb.png", width: 150, height: 150)
    //     )
    //   ],
    //
    // );
  }
}