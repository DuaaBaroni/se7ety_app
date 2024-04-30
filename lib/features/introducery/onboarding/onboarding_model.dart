class OnboardingModel{
   late final String image;
   late final String title;
   late final String description;
    
    OnboardingModel({required this.image ,required this.title, required this.description});

}

List<OnboardingModel> pages =[
   OnboardingModel(image: "assets/on1.svg", title: "ابحث عن دكتور متخصص", description: "اكتشف مجموعه خاصه من الاطباء الخبراء و المتخصصين في مختلف المجالات"),
   OnboardingModel(image: "assets/on2on1.svg", title: "سهوله الحجز", description: "احجز المواعيد في ضغطه زر وفي اي وقت و مكان"),
   OnboardingModel(image: "assets/on3.svg", title: "آمن و سري", description: " كن مطمئنا لان خصوصيتك وامانك هما أهم أولوياتنا"),
];
