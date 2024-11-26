import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learn/blocs/client_bloc.dart';
import 'package:flutter_bloc_learn/blocs/client_events.dart';
import 'package:flutter_bloc_learn/blocs/client_state.dart';
import 'package:flutter_bloc_learn/models/client.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  
  late final ClientBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ClientBloc();
    bloc.add(LoadClientEvent());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  String randomName() {
    final rand = Random();
    return ['Kaue Teldson', 'Vinicius Camargo', 'Yasmin Lemos', 'Maria Carolina'].elementAt(rand.nextInt(4));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clientes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              bloc.add(AddClientEvent(client: Client(nome: randomName())));
            }, 
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: BlocBuilder<ClientBloc, ClientState>(
          bloc: bloc, 
          builder: (context, state) {
            if(state is ClientInitialState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if(state is ClientSuccessState) {
              final clientsList = state.clients;
              return ListView.separated(
                itemCount: clientsList.length,
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Text(clientsList[index].nome.substring(0,1)),
                    ),
                  ),
                  title: Text(clientsList[index].nome),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      bloc.add(RemoveClientEvent(client: clientsList[index]));
                    }, 
                  ),
                ),
                separatorBuilder: (_,__) => const Divider(),
              );
            }
            return Container();  
          }
        ),
      ),
    );
  }
}