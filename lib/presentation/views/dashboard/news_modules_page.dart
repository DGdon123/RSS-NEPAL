import 'package:flutter/material.dart';
import 'package:rss/domain/entities/news/new_modules_entities.dart';
import 'package:rss/presentation/views/news/modules_wise_news/module_wise_news.dart';

import '../../../common/constants/static_image_constants.dart';
import '../../../common/constants/strings.dart';

class NewsModulesPage extends StatelessWidget {
  final List<NewsModuleEntity> newsModules;
  const NewsModulesPage({Key? key, required this.newsModules})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: primaryColor,
          // gradient: LinearGradient(
          //     colors: [primaryColor, Colors.blueAccent],
          //     begin: const FractionalOffset(0.7, 2.0),
          //     stops: [0.0, 1.0],
          //     tileMode: TileMode.clamp),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            height: 280,
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30, top: 20),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: newsModules.length,
                itemBuilder: (BuildContext ctx, index) {
                  var letter = newsModules[index].name![0];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => ModuleWiseNewsPage(
                            id: newsModules[index].id!,
                            moduleName: newsModules[index].name!,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //               Shimmer.fromColors(
                          //                 baseColor: Colors.primaries[
                          //                     Random().nextInt(Colors.primaries.length)],
                          //                 highlightColor: Colors.primaries[
                          //                     Random().nextInt(Colors.primaries.length)],
                          //                 enabled: true,
                          //                 child: Text(
                          //                   letter,
                          //                   style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          //   fontWeight: FontWeight.bold,
                          //   color:primaryColor,

                          // )
                          //                 ),
                          //               ),
                          newsModules[index].name![0] == "M"
                              ? Container(
                                  width: 100,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: AssetImage(
                                              StaticAppImage.multi))),
                                )
                              : newsModules[index].name![0] == "N"
                                  ? Container(
                                      width: 100,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.contain,
                                              image: AssetImage(
                                                  StaticAppImage.nepaliImg))),
                                    )
                                  : newsModules[index].name![0] == "E"
                                      ? Container(
                                          width: 100,
                                          height: 70,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.contain,
                                                  image: AssetImage(
                                                      StaticAppImage
                                                          .englishImg))),
                                        )
                                      : newsModules[index].name![0] == "I"
                                          ? Container(
                                              width: 100,
                                              height: 70,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.contain,
                                                      image: AssetImage(
                                                          StaticAppImage
                                                              .Intel))),
                                            )
                                          : newsModules[index].name![0] == "M"
                                              ? Container(
                                                  width: 100,
                                                  height: 70,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.contain,
                                                          image: AssetImage(
                                                              StaticAppImage
                                                                  .multi))),
                                                )
                                              : Text("data"),

                          // Text(
                          //   letter,
                          //   style: Theme.of(context)
                          //       .textTheme
                          //       .headline2!
                          //       .copyWith(
                          //           fontWeight: FontWeight.bold,
                          //           color: primaryColor,
                          //           fontSize: 25),
                          // ),
                          // Container(
                          //   width: 100,
                          //   height: 70,
                          //   decoration: BoxDecoration(
                          //       image: DecorationImage(
                          //           fit: BoxFit.contain,
                          //           image: AssetImage(StaticAppImage.multi))),
                          // ),

                          Text(newsModules[index].name.toString(),
                              style: Theme.of(context).textTheme.bodyText1!)
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(4, 4),
                              blurRadius: 8,
                              color: Colors.blue.withOpacity(0.1)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
