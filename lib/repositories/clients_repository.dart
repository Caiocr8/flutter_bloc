import 'package:flutter_bloc_learn/models/client.dart';

class ClientsRepository {
  final List<Client> _clients = [];

  List<Client> loadClients() {
    _clients.addAll([
      Client(nome: "Caio Andrade"),
      Client(nome: "Symon Davi"),
      Client(nome: "Sophia Rocha"),
      Client(nome: "Aline Almeida")
    ]);
    return _clients;
  }

  List<Client> addClient(Client client) {
    _clients.add(client);
    return _clients;
  }

  List<Client> removeClient(Client client) {
    _clients.remove(client);
    return _clients;
  }

  


}