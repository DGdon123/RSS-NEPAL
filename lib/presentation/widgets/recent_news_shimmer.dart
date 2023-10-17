import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecentNewsShim extends StatelessWidget {
  const RecentNewsShim({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        baseColor: Color(0xFFEBEBF4),
        highlightColor: Color(0xFFF4F4F4),
        enabled: true,
        child: ListView.builder(
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0,right: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 48.0,
                  height: 48.0,
                
                  decoration: BoxDecoration(  color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: 40.0,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          itemCount: 9,
        ),
      ),
    ),
        // child: Shimmer.fromColors(
        //   baseColor: Colors.blueGrey,
        //   highlightColor: Colors.blueAccent,
        //   enabled: true,
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 20),
        //     child: ListView.builder(
        //       itemBuilder: (_, __) => Padding(
        //         padding: const EdgeInsets.only(bottom: 8.0),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Container(
        //               width: 200.0,
        //               height: 20.0,
        //             ),
        //             Row(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: <Widget>[
        //                 Container(
        //                   width: 48.0,
        //                   height: 48.0,
        //                   color: Colors.white,
        //                 ),
        //                 const Padding(
        //                   padding: EdgeInsets.symmetric(horizontal: 8.0),
        //                 ),
        //                 Expanded(
        //                   child: Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: <Widget>[
        //                       Container(
        //                         width: double.infinity,
        //                         height: 8.0,
        //                         color: Colors.red,
        //                       ),
        //                       const Padding(
        //                         padding: EdgeInsets.symmetric(vertical: 2.0),
        //                       ),
        //                       Container(
        //                         width: double.infinity,
        //                         height: 8.0,
        //                         color: Colors.white,
        //                       ),
        //                       const Padding(
        //                         padding: EdgeInsets.symmetric(vertical: 2.0),
        //                       ),
        //                       Container(
        //                         width: 40.0,
        //                         height: 8.0,
        //                         color: Colors.white,
        //                       ),
        //                       Container(
        //                         width: 40.0,
        //                         height: 8.0,
        //                         color: Colors.white,
        //                       ),
        //                       Container(
        //                         width: 40.0,
        //                         height: 8.0,
        //                         color: Colors.white,
        //                       ),
        //                     ],
        //                   ),
        //                 )
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //       itemCount: 6,
        //     ),
        //   ),
        ),
      
    );
  }
}
