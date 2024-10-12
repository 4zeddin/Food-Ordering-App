class UnboardingContent {
  String title;
  String image;
  String description;

  UnboardingContent(
      {required this.title, required this.image, required this.description});
}

List<UnboardingContent> content = [
  UnboardingContent(
      title: "Pick your food from our menu\n", image: "images/screen1.png", description: "Select from our \n    Best Menu"),
  UnboardingContent(
      title: "You can pay cash on Delevery\n       Card payement is available", image: "images/screen2.png", description: "Easy and Online payment"),
  UnboardingContent(
      title: "Deliver your food at your\n        Doortap", image: "images/screen3.png", description: "Quick Delevery at you Doorstap")
];
