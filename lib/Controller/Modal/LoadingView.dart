import 'package:flutter/material.dart';



class GKLoadingView extends StatefulWidget {
  final BuildContext parentContext;

  const GKLoadingView({super.key, required this.parentContext});

  @override
  State<GKLoadingView> createState() => _GKLoadingView();
}

class _GKLoadingView extends State<GKLoadingView>{

  @override
  Widget build(BuildContext context) {

    return
      AlertDialog(

        content:  IntrinsicHeight(
          child: Row(
            children: [

              const CircularProgressIndicator(
                strokeWidth: 5.7,
                color: Colors.black
              ),

              Container(width: 15),

              const Flexible(
                child:  Text("Checking reuqest. Please wait...",
                  style: TextStyle(fontFamily: "SF-Pro-Round-Medium", 
                            color: Color(0xFF434343),fontSize: 15
                          ),
                  textAlign: TextAlign.left,
                ),
              )
              
            ],
          ),
        )

      );
  }
}