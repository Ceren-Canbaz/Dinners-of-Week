import 'package:dinners_of_week/model/auth.dart';
import 'package:dinners_of_week/presentation/style/decoration.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({super.key});

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  @override
  Widget build(BuildContext context) {
    final auth = ModalRoute.of(context)!.settings.arguments as Auth;

    return Scaffold(
      backgroundColor: beige,
      body: WillPopScope(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              Wrap(
                children: [
                  Text(
                    "Welcome",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: darkGreen, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    auth.username,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: darkGreen, fontWeight: FontWeight.w200),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Card(
                color: brown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Join a team!",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Enter the team code your team shared with you, and don't miss out on anything",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w300),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 64.0,
                      ),
                      child: TextField(
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            // Aktif durumdayken alt çizgi rengi
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            // Pasif durumdayken alt çizgi rengi
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  ///NAVIGATE TO  CREATE TEAM page
                },
                child: Card(
                  color: darkGreen,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Create a Team!",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "If you want to make edits in the weekly meal planning and share it with your team, what are you waiting for? Quickly create a team and invite your team members!",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
              IconButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();

                    await prefs
                        .remove('dowUsername'); // 'username' anahtarını siler
                    setState(() {});
                  },
                  icon: Icon(Icons.run_circle))
            ],
          ),
        ),
        onWillPop: () async {
          return false;
        },
      ),
    );
  }
}
