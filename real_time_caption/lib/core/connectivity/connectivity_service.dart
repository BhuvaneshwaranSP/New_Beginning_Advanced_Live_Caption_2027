enum ConnectivityStatus { online, offline, reconnecting }

class ConnectivityService {
  const ConnectivityService();
  ConnectivityStatus get initialStatus => ConnectivityStatus.online;
  // Future: replace this local status with the project's connectivity source when real connectivity is integrated.
}
