import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/Components/UI%20Design/Custom-Widget-Design.dart';
import 'package:my_app/Components/UI%20Design/TextField-Design.dart';
import 'package:my_app/Model/GK-DataModel/GKBorrowerProfileDataModel.dart';
import 'package:my_app/Persistent/gk_sqllite.dart';

class PaydayTab1VC extends StatefulWidget {

  @override
  _PaydayTab1VC createState() => _PaydayTab1VC();
} 

class _PaydayTab1VC extends State<PaydayTab1VC>{
  late List<CategoryModel> categories;
  late List<ProductModel> products;
  
  List<CategoryContent> get categoryContents => categories.map((category) => CategoryContent(
          category: category,
          products: products.where((product) => product.id == category.id).toList())).toList();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Stack(
        children: [

          // MARK: curved oval BG
          Positioned(
            top: -(800 * 0.38) + topPadding,
            left: 0,
            right: 0,
            child: MyArc(diameter: size.width)
          ),

          // MARK: available bal
          paydayContentView(topPadding, size),

          // MARK: chat support
          chatSupportVIEW(topPadding, size)
        ]
      ),
    );
  }
}


SizedBox paydayContentView(double safeTop, Size size){
  return
  SizedBox(
    height: size.height,
    child: Column(
      children: [
        Container(height: safeTop, color: Colors.black.withOpacity(0.18)),
        
        availableContentVIEW(safeTop, size),
        
        Container(height: 5),

        Expanded(child: pdyTransactionHistoryVIEW(size))
      ]
    ),
  );
}


SizedBox availableContentVIEW(double safeTop, Size size){
  return  
  SizedBox(
    height: (800 * 0.38) + safeTop, width: size.width,
    child: Column(
      children: [
        
        paydayDisplayFundVIEW(size),

        const Spacer(),

        Row(
          children: [
            const Spacer(),

            Stack(
              clipBehavior: Clip.none,
              children: [
                const Positioned(
                  left: -35,
                  child: Text("PHP",
                    style:  TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white)
                  ),
                ),

                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: size.width - 80),
                  child: 
                    Container(
                      padding: const EdgeInsets.only(top: 8),
                      child: const Text("100,000.00",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style:  TextStyle(fontSize: 48, fontWeight: FontWeight.w700, 
                                    color: Colors.white, overflow: TextOverflow.ellipsis
                                  )
                      ),
                    )
                )
              ]
            ),
          
            const Spacer(),
          ]
        ),

        const Text("Available Funds",
          style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)
        ),


        const Spacer(),

        Container(
          margin: const EdgeInsets.only(left: 18, right: 18, bottom: 50),
          child: Column(
            children: [
              Row(
                children: [
                  Text("Withdrawn", style: pdyTxtStyle(fWeight: FontWeight.w400)),
                  const Spacer(),
                  Text("₱100,00.00", style: pdyTxtStyle())
                ]
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Text("Total Funds", style: pdyTxtStyle(fWeight: FontWeight.w400)),
                  const Spacer(),
                  Text("₱1,000.00", style: pdyTxtStyle()),
                ]
              ),
            ]
          ),
        ),

        const Spacer(),
      ]
    )
  );
}


Row paydayDisplayFundVIEW(Size size) {
  return
  Row(
    children: [
      Container(
        margin: const  EdgeInsets.only(top: 20, left: 18),
        child:  const Text("Total Fund", 
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)
                )
      ),
      
      const Spacer(),

      Container(
        height: 60, width: 65,
        decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30)),
                      color: Color.fromARGB(255, 178, 226, 141),
                    ),
        child:  Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: const Icon(Icons.arrow_forward_rounded,color: Colors.white,size: 40,)
                ),
      )
    ]
  );
}


Positioned chatSupportVIEW(double safeTop, Size size){
  return 
  Positioned(
    top: (800 * 0.377),
    left: size.width - 78,
    child: Container(height: 63, width: 63,
    padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(31.5),
                    color: Color(0xFF9ECA7D),
                    boxShadow: 
                      <BoxShadow>[
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          offset: const Offset(1.5, 3),
                          blurRadius: 7,
                        ),
                      ]
                  ),
      child: Image.asset('assets/payday-icon/pdy_chat_support/pdy_chat_support.png'),
    )
  );
}

Column pdyTransactionHistoryVIEW(Size size){
  // final List<List<String<String>>> entries2 = <List<String<String>>>[["GG",["A", "B", "C"]],["GG1",["D","E","F"]],["GG2",["G","H","i"]]];
  // final List<String> entries2 = <String>["A", "B", "C"];
  final List entries = [{"asd1",["A", "B", "C"]},{"asd2",["A1", "B1", "C1"]},{"asd2",["A1", "B1", "C1"]},{"asd2",["A1", "B1", "C1"]},{"asd2",["A1", "B1", "C1"]},{"asd2",["A1", "B1", "C1"]}];
  final List<int> colorCodes = <int>[600, 500, 100, 300, 200, 600, 500, 100, 300];  


  return 
  Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const Padding(
        padding: EdgeInsets.only(left: 18),
        child: Text("Recent Transactions", 
                  style: TextStyle(color: Color(0xFF434343),fontSize: 16, fontWeight: FontWeight.bold)
                )
      ),

      Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 35,top: 5),
                shrinkWrap: true,
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return 
                    Column(
                      children: [
                        Container(
                          width: size.width,
                          padding: const EdgeInsets.only(top: 5, bottom: 5, left: 18, right: 15),
                          color: Color(0xffededed),
                          child: Text(entries[index].elementAt(0), style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold),)
                        ),
                        ...entries[index].elementAt(1).map((product) {
                          return Text(product);
                        }),
                      ],
                    );
                }
              ),
            ],
          ),
        ),
      )
    ]
  );
}

class CategoryContent {
  final CategoryModel? category;
  final List<ProductModel>? products;

  CategoryContent({
    this.category,
    this.products,
  });
}
class CategoryModel {
  final String? id;
  final String? categoryName;

  CategoryModel({
    this.id,
    this.categoryName,
  });
}
class ProductModel {
  final String? id;
  final String? title;
  final String? desc;
  final String? imgUrl;

  ProductModel({
    this.id,
    this.title,
    this.desc,
    this.imgUrl,
  });
}