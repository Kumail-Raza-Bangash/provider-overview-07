import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_overview_07/model/babies.dart';
import 'package:provider_overview_07/model/dogs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Dog>(
          create: (context) => Dog(name: 'dog07', breed: 'breed07', age: 3),
          ),
          FutureProvider<int>(initialData: 0, create: (context){
            final int dogAge = context.read<Dog>().age;
            final babies = Babies(age: dogAge);
            return babies.getBabies();
          },
          ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Provider Overview 07',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider 07'),
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
             Text('- name: ${context.watch<Dog>().name}', style: TextStyle(fontSize: 20.0,),),
             const SizedBox( height: 5.0,),
             BreedAndAge(),
          ],
        ),
      ),
    );
  }
}

class BreedAndAge extends StatelessWidget {
  const BreedAndAge({super.key,});

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
              Text('- breed: ${context.select<Dog, String>((Dog dog) => dog.breed)}', style: TextStyle(fontSize: 20.0,),),
             const SizedBox( height: 5.0,),
             Age(),
          ],
        ),
    );
  }
}

class Age extends StatelessWidget {
  const Age({super.key,});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
             Text('- age: ${context.select<Dog, int>((Dog dog) => dog.age)}', style: const TextStyle(fontSize: 20.0,),),
             const SizedBox(height: 5.0,),
             Text('number of babies: ${context.watch<int>()}', style:  TextStyle(fontSize: 20.0,),),
             const SizedBox(height: 5.0,),
              ElevatedButton(onPressed: () => context.read<Dog>().grow(), 
              child: const Text('Grow', style:  TextStyle(fontSize: 20.0,),),),

          ],
        ),
    );
  }
}