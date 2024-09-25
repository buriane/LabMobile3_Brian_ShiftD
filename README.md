# Favorite Marvel Heroes

Nama: Brian Cahya Purnama

NIM: H1D022009

Shift Lama: C

Shift Baru: D

# Pejelasan Kode

## 1. main.dart

```
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isLoggedIn ? const HomePage() : const LoginPage(),
    );
  }
}
```

- Menggunakan SharedPreferences untuk memeriksa status login.
- Memilih antara HomePage atau LoginPage sebagai layar awal berdasarkan status login, kalau isLoggedIn true, maka akan masuk ke HomePage(), kalau engga ya ke LoginPage().

## 2. heroDB.dart
```
class _HeroDatabaseState extends State<HeroDatabase> {
  List<String> heroes = ['Iron Man', 'Captain America', ...];
  List<String> favoriteHeroes = [];

  _toggleFavorite(String hero) async {
    setState(() {
      if (favoriteHeroes.contains(hero)) {
        favoriteHeroes.remove(hero);
      } else {
        favoriteHeroes.add(hero);
      }
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoriteHeroes', favoriteHeroes);
  }
}
```

- Buat nampilin daftar hero marvel.
- Fungsi _toggleFavorite digunakan buat menandai heronya sebagai favorite.
- Menyimpan dan memuat daftar favorit menggunakan SharedPreferences.

## 3. home.dart
```
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Marvel Heroes'),
      ),
      drawer: const SideMenu(),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HeroDatabase()),
          ),
          child: const Text('Lihat List Marvel Heroes'),
        ),
      ),
    );
  }
}
```

- Menggunakan Scaffold dengan AppBar dan Drawer (buat menu samping).
- Menampilkan pesan selamat datang dan tombol untuk melihat daftar hero.
- Tombol buat mengarahkan ke halaman HeroDatabase.

## 4. login.dart
```
class _LoginPageState extends State<LoginPage> {
  void _login() async {
    if (_usernameController.text == 'draco' &&
        _passwordController.text == 'mimin123') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('username', _usernameController.text);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Username atau Password Salah!')));
    }
  }
}
```

- Ada dua TextField untuk username dan password.
- Memeriksa inputan pengguna (username: 'draco', password: 'mimin123').
- Jika login berhasil, menyimpan status login dan username ke SharedPreferences.
- Mengarahkan ke HomePage setelah login berhasil.
- Jika login gagal, maka akan nampilin snackbar yang isinya tulisan pesan error.

## 5. profile.dart
```
class _ProfileState extends State<Profile> {
  String username = '';
  List<String> favoriteHeroes = [];

  _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'Username';
      favoriteHeroes = prefs.getStringList('favoriteHeroes') ?? [];
    });
  }
}
```

- Memuat username dari SharedPreferences.
- Menampilkan daftar hero favorit yang disimpan yang nantinya ditampilkan dalam Card dengan menggunakan ListView.builder.

## 6. sideMenu.dart
```
class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          // ... (ListTile lainnya untuk List Heroes dan Profile)
          ListTile(
            title: const Text('Logout'),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', false);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
```

- Navigasi buat pindah ke Home, List Heroes, dan Profile.
- Opsi Logout yang menghapus status login dan kembali ke halaman login.

# Demo
![Demo GIF](demo.gif)
