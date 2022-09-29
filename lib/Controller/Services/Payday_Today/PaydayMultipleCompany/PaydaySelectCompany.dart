import 'package:flutter/material.dart';

class PaydaySelectCompanyVC extends StatefulWidget {

  @override
  State<PaydaySelectCompanyVC> createState() => _PaydaySelectCompanyVC();
}

class _PaydaySelectCompanyVC extends State<PaydaySelectCompanyVC> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: 
      LayoutBuilder(
          
        builder: (context, constraints) => ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),

          child: IntrinsicHeight(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                children: [
                  Text("Please select a company"),

                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return 
                          Card();
                      }
                    )
                  )
                ]
              )
            )
          )
        )

      )
    );
  }

}