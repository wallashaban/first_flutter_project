import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/layout/shop_layout/cubit/cubit.dart';
import 'package:udemy_course/layout/shop_layout/cubit/states.dart';
import 'package:udemy_course/models/shop_model/home_model.dart';
import 'package:udemy_course/shared/components/constants.dart';

class ShopHomeScreen extends StatelessWidget {
  const ShopHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return cubit.model != null
            ? buildProductItem(cubit.model!)
            : const Text('');
      },
    );
  }

  Widget buildProductItem(HomeModel model) => SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              items: model.data!.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage(
                        '${e.image}',
                      ),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayInterval: const Duration(seconds: 3),
                enableInfiniteScroll: true,
                height: 250.0,
                initialPage: 0,
                reverse: false,
                viewportFraction: 1.0,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.3,
              children: List.generate(
                model.data!.products.length,
                (index) => buildGridViewItem(model.data!.products[index]),
              ),
            ),
          ],
        ),
      );

  Widget buildGridViewItem(Products model) => Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(model.image!),
                height: 140,
              ),
              if (model.discount != 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  model.name!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      style: TextStyle(color: defaultColor),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if(model.discount!=0)
                    Text('${model.oldPrice}',style: const TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough,),),
                   const Spacer(),
                   const Icon(Icons.favorite_border),
                  
                  ],
                ),
              ],
            ),
          )
        ],
      );
}
