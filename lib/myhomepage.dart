import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> data = [];
  int currentLength = 0;

  final int increment = 10000;
  bool isLoading = false;
  final _scrollController = ScrollController();
  bool isClosed = false;

  @override
  void initState() {
    _loadMore();
    _scrollController.addListener(() {
      if (_scrollController.offset >= 5 && _scrollController.offset <= 200) {
        if (isClosed) {
          _scrollController.jumpTo(0);
        } else {
          _scrollController.jumpTo(202);
        }
      }
    });
    super.initState();
  }

  Future _loadMore() async {
    setState(() {
      isLoading = true;
    });
    // Add in an artificial delay
    await Future.delayed(const Duration(seconds: 2));
    for (var i = currentLength; i <= currentLength + increment; i++) {
      data.add(i);
    }
    setState(() {
      isLoading = false;
      currentLength = data.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    //t count = height * 5.floor() as int;double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lazy loading"),
        backgroundColor: Colors.green,
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              print("Item printed: $index");
              return MyItem(index);
            }, childCount: data.length),
          )
        ],
      ),
      // body: LazyLoadScrollView(
      //   isLoading: isLoading,
      //   scrollOffset: 100,
      //   onEndOfPage: () => _loadMore(),
      //   child: ListView.builder(
      //     shrinkWrap: true,
      //     itemCount: data.length,
      //     itemBuilder: (context, position) {
      //       print('Printing $position');
      //       return MyItem(position);
      //     },
      //   ),
      // ),
    );
  }
}

class MyItem extends StatelessWidget {
  final int position;

  MyItem(this.position, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 200,
        width: double.infinity,
        child: Column(
          children: [
            Image.network(
              "https://res.cloudinary.com/dhakacity/image/upload/c_scale,w_848,h_412/f_auto,q_auto/v1670251599/rock-paradise-tent.jpg",
              height: 150,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            Divider(
              height: 5,
              color: Colors.red,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Rock Paradise Sajek $position",
                style: const TextStyle(fontSize: 30),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DemoItem extends StatelessWidget {
  final int position;

  DemoItem({required this.position});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Colors.deepOrange,
                  height: 40.0,
                  width: 40.0,
                ),
                SizedBox(width: 8.0),
                Text("Item $position"),
              ],
            ),
            Text("GeeksforGeeks.org was created with a goal "
                "in mind to provide well written, well "
                "thought and well explained solutions for selected"
                " questions. The core team of five super geeks"
                " constituting of technology lovers and computer"
                " science enthusiasts have been constantly working"
                " in this direction ."),
          ],
        ),
      ),
    );
  }
}
