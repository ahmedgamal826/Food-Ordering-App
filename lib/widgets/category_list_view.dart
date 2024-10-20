import 'package:flutter/material.dart';
import 'package:food_ordering_app/widgets/custom_category.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({
    super.key,
    required this.categoryName,
    this.onTap,
  });

  final String categoryName;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();

    List<CustomCategory> categories = [];
    if (categoryName == 'Drinks') {
      categories = [
        CustomCategory(
          image: 'assets/images/guava.png',
          categoryName: 'Guava Juice',
          onTap: () {
            Navigator.pushNamed(context, 'GuavaJuice');
          },
        ),
        CustomCategory(
          image: 'assets/images/water-bottle.png',
          categoryName: 'Water',
          onTap: () {
            Navigator.pushNamed(context, 'water');
          },
        ),
        CustomCategory(
          image: 'assets/images/cocktail.png',
          categoryName: 'Cocktail Juice',
          onTap: () {
            Navigator.pushNamed(context, 'cocktailJuice');
          },
        ),
        CustomCategory(
          image: 'assets/images/apple-juice.png',
          categoryName: 'Apple Juice',
          onTap: () {
            Navigator.pushNamed(context, 'appleJuice');
          },
        ),
        CustomCategory(
          image: 'assets/images/mango.png',
          categoryName: 'Mango Juice',
          onTap: () {
            Navigator.pushNamed(context, 'mangoJuice');
          },
        ),
        CustomCategory(
          image: 'assets/images/orange-juice.png',
          categoryName: 'Orange Juice',
          onTap: () {
            Navigator.pushNamed(context, 'orangeJuice');
          },
        ),
        CustomCategory(
          image: 'assets/images/strawberry-juice.png',
          categoryName: 'Strawberry Juice',
          onTap: () {
            Navigator.pushNamed(context, 'strawberryJuice');
          },
        ),
      ];
    } else if (categoryName == 'Foods') {
      categories = [
        CustomCategory(
          categoryName: 'Burger',
          image: 'assets/images/burger.png',
          onTap: () {
            Navigator.pushNamed(context, 'burgerScreen');
          },
        ),
        CustomCategory(
          categoryName: 'Fries',
          image: 'assets/images/french-fries.png',
          onTap: () {
            Navigator.pushNamed(context, 'friesScreen');
          },
        ),
        CustomCategory(
          categoryName: 'Pizza',
          image: 'assets/images/pizza.png',
          onTap: () {
            Navigator.pushNamed(context, 'pizzaScreen');
          },
        ),
        CustomCategory(
          categoryName: 'Chicken',
          image: 'assets/images/chicken.png',
          onTap: () {
            Navigator.pushNamed(context, 'chickenScreen');
          },
        ),
        CustomCategory(
          categoryName: 'Fish',
          image: 'assets/images/fish.png',
          onTap: () {
            Navigator.pushNamed(context, 'fishScreen');
          },
        ),
        CustomCategory(
          categoryName: 'Meat',
          image: 'assets/images/meat.png',
          onTap: () {
            Navigator.pushNamed(context, 'meatScreen');
          },
        ),
        CustomCategory(
          categoryName: 'Rice',
          image: 'assets/images/rice-bowl.png',
          onTap: () {
            Navigator.pushNamed(context, 'riceScreen');
          },
        ),
        CustomCategory(
          categoryName: 'Pasta',
          image: 'assets/images/pasta.png',
          onTap: () {
            Navigator.pushNamed(context, 'pastaScreen');
          },
        ),
        CustomCategory(
          categoryName: 'Sushi',
          image: 'assets/images/sushi.png',
          onTap: () {
            Navigator.pushNamed(context, 'sushiScreen');
          },
        ),
      ];
    } else if (categoryName == 'Sweets') {
      categories = [
        CustomCategory(
          categoryName: 'Chocolate Cake',
          image: 'assets/images/chocolate-cake.png',
          onTap: () {
            Navigator.pushNamed(context, 'chocolateCake');
          },
        ),
        CustomCategory(
          categoryName: 'Donut',
          image: 'assets/images/donut.png',
          onTap: () {
            Navigator.pushNamed(context, 'donuts');
          },
        ),
        CustomCategory(
          categoryName: 'Ice Cream',
          image: 'assets/images/ice-cream.png',
          onTap: () {
            Navigator.pushNamed(context, 'iceCream');
          },
        ),
        CustomCategory(
          categoryName: 'Waffle',
          image: 'assets/images/waffle.png',
          onTap: () {
            Navigator.pushNamed(context, 'waffle');
          },
        ),
        CustomCategory(
          image: 'assets/images/desserts.png',
          categoryName: 'Cupcake',
          onTap: () {
            Navigator.pushNamed(context, 'cupcake');
          },
        )
      ];
    } else if (categoryName == 'Popular Meals') {
      categories = [
        CustomCategory(
          image: 'assets/images/burger and drink.png',
          categoryName: 'Burger + Pepsi',
          onTap: () {
            Navigator.pushNamed(context, 'burger and pepsi');
          },
        ),
        CustomCategory(
          image: 'assets/images/fish and rice.png',
          categoryName: 'Fish + Rice',
          onTap: () {
            Navigator.pushNamed(context, 'fishandrice');
          },
        ),
        CustomCategory(
          image: 'assets/images/kabsa.png',
          categoryName: 'Meat + Rice',
          onTap: () {
            Navigator.pushNamed(context, 'meatandjuice');
          },
        ),
        CustomCategory(
          image: 'assets/images/chicken-rice.png',
          categoryName: 'Chicken + Rice',
          onTap: () {
            Navigator.pushNamed(context, 'chickenandrice');
          },
        ),
        CustomCategory(
          image: 'assets/images/fast-food (2).png',
          categoryName: 'Burger + Fries',
          onTap: () {
            Navigator.pushNamed(context, 'burgerandfries1');
          },
        ),
        CustomCategory(
          image: 'assets/images/chicken-soup.png',
          categoryName: 'Pasta + Chicken',
          onTap: () {
            Navigator.pushNamed(context, 'pastaandChicken');
          },
        ),
      ];
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 10),
          child: Row(
            children: [
              Text(
                categoryName,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                },
                child: const Text(
                  'View all >',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xffF97316),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            children: categories,
          ),
        ),
      ],
    );
  }
}
