import 'package:flutter/material.dart';

import 'controllers/__NAME__FeatureController.dart';

class __NAME__FeatureView extends StatefulWidget {
    __NAME__FeatureController controller;
    __NAME__FeatureView({required this.controller});

    State<__NAME__FeatureView> createState() => ___NAME__FeatureViewState();
}

class ___NAME__FeatureViewState extends State<__NAME__FeatureView> {
    @override
    void initState() {
        widget.controller.addListener(() {
            /// @todo: implement
            setState(() => null);
        });
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return Placeholder();
    }
}