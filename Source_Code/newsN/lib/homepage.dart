import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsn/apimanager.dart';
import 'package:newsn/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<NewsModel> _newsModel;

  @override
  void initState()
  {
    _newsModel  = API_Manager().getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark
        ),
        title: Center(child: Text("News Nation",style: TextStyle(color: Colors.blueAccent))),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child:FutureBuilder<NewsModel>(
          future: _newsModel,
          builder: (context,snapshot)
            {
              if(snapshot.hasData)
                {
                  return ListView.builder(
                    itemCount: snapshot.data?.articles.length,
                      itemBuilder: (context,index)
                      {
                        var article = snapshot.data?.articles[index];
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: Card(
                            elevation: 10,
                            shadowColor: Colors.blueAccent,
                            child: Container(
                              height: 120,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children:<Widget>[
                                    Card(
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: AspectRatio(
                                          aspectRatio: 1,
                                          child: Image.network(
                                            article!.urlToImage,
                                            fit: BoxFit.cover,
                                          )
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          //Text(formattedTime),
                                          Text(
                                            article.title,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            article.description,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  ),
                              )
                              ),
                          ),
                          );
                      }
                  );
                }
              else
                {
                  return Center (child: CircularProgressIndicator());
                }
            }
        )
      ),
    );
  }
}
