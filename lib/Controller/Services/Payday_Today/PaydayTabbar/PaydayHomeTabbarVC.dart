import 'package:flutter/material.dart';
import 'package:my_app/Controller/Services/Payday_Today/PaydayMoreTab/PaydayMoreTabVC.dart';
import 'package:my_app/Controller/Services/Payday_Today/PaydayTab1/PaydayTab1.dart';

class PaydayHomeTabbar extends StatefulWidget {
  @override
  State<PaydayHomeTabbar> createState() => _PaydayHomeTabbar();
}

class _PaydayHomeTabbar extends State<PaydayHomeTabbar>{
  
  @override
  Widget build(BuildContext context) {
  
    final topPadding = MediaQuery.of(context).padding.top;
    Size size = MediaQuery.of(context).size;

    return 
      Scaffold(
        endDrawer: Container(
            margin: EdgeInsets.only(top: topPadding),
            child: sideBarDrawer(context)
        ),
    
        body: Builder( builder: (context1) => Stack(
          children: [

            DefaultTabController(
              length: 5,
              child: Scaffold(
                bottomNavigationBar: menu(context1),
                body: TabBarView(
                  children: [
                    PaydayTab1VC(),
                    Container(child: Icon(Icons.directions_car)),
                    Container(child: Icon(Icons.directions_transit)),
                    Container(child: Icon(Icons.directions_bike)),
                    Container(child: GestureDetector(
                      onTap: (){

                    },)
                    )
                  ]
                )
              )
            ),

            Column(
              children: [
                const Spacer(),
                Row(
                  children: [
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.only(top: 15,bottom: 12,left: 12,right: 12),
                      margin: const EdgeInsets.only(bottom: 28),
                      width: 64, height: 64,
                      decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(32),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        offset: const Offset(1.5, 3),
                                        blurRadius: 7,
                                      ),
                                    ],
                                  ),
                      child: Image.asset('assets/payday-icon/pdy-tab-icon/payday_reqAmount_notActive/pdy_req_amnt_unSelected.png'),
                    ),

                    const Spacer(),
                  ]
                )
              ]
            ),

            Column(
              children: [
                const Spacer(),
                Row(
                  children: [
                    const Spacer(),
                    
                    Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.only(top: 15,bottom: 12,left: 12,right: 12),
                      width: size.width / 5, height: 62,
                      decoration: const BoxDecoration(
                                    color: Colors.transparent
                                  ),
                
                      child: GestureDetector(onTap: (){
                        Scaffold.of(context1).openEndDrawer();
                      })
                    ),
                  ]
                )
              ]
            )
      
          ]
        )
      )
    );
      
  }

  Widget menu(BuildContext context1) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Container(
        height: 62,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black,
              offset: Offset(-5, 5),
              blurRadius: 10, 
            ),
          ],
        ),
        
        child: const TabBar(
          labelColor: Colors.black,
          labelStyle: TextStyle(fontSize: 13),
          unselectedLabelColor: Color(0xFF9A9A9A),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.transparent,
          padding: EdgeInsets.zero,
          indicatorPadding: EdgeInsets.zero,
          labelPadding: EdgeInsets.zero,

          tabs: [
            Tab(
              text: "Transaction",
              icon: Icon(Icons.euro_symbol),
            ),
            Tab(
              text: "Vouchers",
              icon: Icon(Icons.assignment),
            ),
            Tab(
              text: "Request",
              icon: Icon(Icons.account_balance_wallet),
            ),
            Tab(
              text: "Transfer",
              icon: Icon(Icons.settings),
            ),
            Tab(
              text: "More",
              icon: Icon(Icons.menu_rounded),
            )
          ],
        )
      )
    );
  }
}