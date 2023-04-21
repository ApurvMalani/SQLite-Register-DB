import 'package:basic/third_page.dart';
import 'package:flutter/material.dart';
import 'package:basic/user_model.dart';
import 'package:basic/sqlite_helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);

      // setstaate..........
    setState(()  {});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text("Flutter Sqlite"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              UsedataBaseProvider.db.deleteAllUsers();
              // setState delate.....................
              setState(() {});
            },
            child: const Text('Delete All',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Colors.black)),
          )
        ],
      ),


      body: FutureBuilder<List<User>>(
        future: UsedataBaseProvider.db.getAllData(),

        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          debugPrint(snapshot.data?.length.toString());


          if (snapshot.hasData) {


            return ListView.builder(
              physics: const BouncingScrollPhysics(),

              // item  count   ...0 ,1,2
              itemCount: snapshot.data!.length,

              itemBuilder: (BuildContext context, int index) {
                User item = snapshot.data![index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  onDismissed: (diretion) {
                    UsedataBaseProvider.db.deleteUserId(item.id);

                  },

                  child: Card(
                    child: ListTile(


                      title: Text('UserName : ${item.username}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email:${item.email}'),
                          Text('Password: ${item.password}'),
                        ],
                      ),
                      leading: CircleAvatar(child: Text(item.id.toString())),

                      onTap: () {

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ThirdClass(true)));
                      },
                    ),
                  ),
                );
              },
            );
          } else {

            return const Center(child: CircularProgressIndicator());
          }
        },
      ),


      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen.shade800,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ThirdClass(false)));



        },
        child: const Icon(Icons.add),
      ),
    );
  }
}




