import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlanSayfa extends StatefulWidget {
  @override
  _PlanSayfaState createState() => _PlanSayfaState();
}

class _PlanSayfaState extends State<PlanSayfa> {
  @override

  Widget build(BuildContext context) {
    //SilverAppBar
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xffb1f2426),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Color(0xffbffff52),
              expandedHeight: 200,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset('assets/images/anitkabir2.jpg', fit: BoxFit.cover,),
                collapseMode: CollapseMode.pin, // ??
                title: Text('FlexibleAppBar'),
                centerTitle: true,
              ),
              title: Text('SliverAppBar'),
              leading: Icon(Icons.arrow_back),
              actions: [Icon(Icons.settings), SizedBox(width: 12,)],
            ),
            Body2()
          ],
        )
      ),
    );
  }
}
Widget Body2() => SliverToBoxAdapter(
  child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      primary: false,
      shrinkWrap: true,
      itemCount: 20,
      itemBuilder: (c, i) => PlanCard(resim: 'assets/images/ayasofya2.jpg')
  )
);
class PlanCard extends StatelessWidget {
  @override
  String resim;

  PlanCard({this.resim});
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Color(0xffb384448),
            borderRadius: BorderRadius.circular(16),
          ),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1.3,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white10,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                        image: DecorationImage(image: AssetImage('assets/images/ayasofya2.jpg'), fit: BoxFit.cover)
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
                    //boxShadow: BoxShadow(offset: Offset(5, 5), blurRadius: 10, color: Colors.white70),
                  ),
                  child: Column(
                    children: [
                      Text('zdvdvxv'),
                      Text('zdvdvxv'),
                      Text('zdvdvxv'),
                    ],
                  ),
                )
              ],
            )
        )
    );
  }
}

Widget Body() => SliverToBoxAdapter(
  child: RawScrollbar(
    isAlwaysShown: true,
    thickness: 13.0,
    radius: Radius.circular(30),
    thumbColor: Color(0xffbffff52),
    child: GridView.builder(
      itemCount: 40,
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(50.0),
          margin: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              color: Color(0xffb384448),
              borderRadius: BorderRadius.circular(16)),
          child: Center(child: Text('$index', style: TextStyle(fontSize: 20, color: Colors.white70),)),);
      },
    ),
  ),
);
