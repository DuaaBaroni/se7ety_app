import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_app/core/utils/color.dart';
import 'package:se7ety_app/core/utils/style.dart';
import 'package:se7ety_app/core/widgets/custom_btn.dart';
import 'package:se7ety_app/features/patient/search/data/doctor_model.dart';
import 'package:se7ety_app/features/patient/appoinments/presentation/widgets/booking.dart';
import 'package:se7ety_app/features/patient/search/presentation/widgets/contact_icon.dart';
import 'package:se7ety_app/features/patient/search/presentation/widgets/tile_widget.dart';


class DoctorProfile extends StatefulWidget {
  final String? doctor;

  const DoctorProfile({Key? key, this.doctor}) : super(key: key);
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  late Doctor doctor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        centerTitle: true,
        title:  Text('بيانات الدكتور', style: getTitleStyle(color: AppColors.white),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            splashRadius: 25,
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('doctors')
            .orderBy('name')
            .startAt([widget.doctor]).endAt(
                ['${widget.doctor!}\uf8ff']).snapshots(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var userData = snapshot.data!.docs.first;
          doctor = Doctor(
              name: userData['name'],
              imageUrl: userData['image'],
              specialization: userData['specialization'],
              rating: userData['rating'],
              email: userData['email'],
              startHour: userData['openHour'],
              endHour: userData['closeHour'],
            address : userData['address'],);
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
               
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: AppColors.white,
                          child: CircleAvatar(
                            backgroundColor: AppColors.white,
                            radius: 60,
                            backgroundImage: (userData['image'] != null)
                                ? NetworkImage(userData['image'])
                                    as ImageProvider
                                : const AssetImage('assets/pro-2.jpg'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "د. ${userData['name']}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: getTitleStyle(),
                          ),
                          Text(
                            userData['specialization'],
                            style: getBodyStyle(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                userData['rating'].toString(),
                                style: getBodyStyle(),
                              ),
                              const Gap(5),
                              const Icon(
                                Icons.star_rounded,
                                size: 20,
                                color: Colors.orange,
                              ),
                            ],
                          ),
                          Gap(15),
                          Row(
                            children: [
                              IconTile(
                                onTap: () {},
                                backColor: AppColors.offWhite,
                                imgAssetPath: Icons.phone,
                                num: '1',
                              ),
                              if (userData['phone2'] != null)
                                IconTile(
                                  onTap: () {},
                                  backColor: AppColors.offWhite,
                                  imgAssetPath: Icons.phone,
                                  num: '2',
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
               const Gap(20),
                Text(
                  "نبذه تعريفية",
                  style: getBodyStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  userData['bio'],
                  style: getSmallStyle(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.offWhite,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TileWidget(
                          text:
                              '${userData['openHour']} - ${userData['closeHour']}',
                          icon: Icons.watch_later_outlined),
                      const SizedBox(
                        height: 15,
                      ),
                      TileWidget(
                          text: userData['address'],
                          icon: Icons.location_on_rounded),
                    ],
                  ),
                ),
                const Divider(),
               const Gap(10),
                Text(
                  "معلومات الاتصال",
                  style: getBodyStyle(fontWeight: FontWeight.w600),
                ),
                const Gap(10),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.offWhite,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TileWidget(text: userData['email'], icon: Icons.email),
                      const Gap(10),
                      TileWidget(text: userData['phone1'], icon: Icons.call),
                      const Gap(10),
                     
                      if (userData['phone2'] != null)
                        TileWidget(text: userData['phone2'], icon: Icons.call),
                    ],
                  ),
                ),
              ],
            )),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding:  const EdgeInsets.all(12),
        child: CustomButton(
          text: 'احجز موعد الان', 
         onPressed:() {
          Navigator.push(
              context,
             MaterialPageRoute(
               builder: (context) => BookingView(doctor: doctor),
             ),
          );
        },
        ),
      ),
    );
  }
}