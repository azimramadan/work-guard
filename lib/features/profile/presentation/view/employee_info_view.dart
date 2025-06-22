import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_guard/core/data/models/user_local_model.dart';
import 'package:work_guard/core/data/models/user_model.dart';
import 'package:work_guard/core/helper/hive_helper.dart';
import 'package:work_guard/features/auth/presentation/view_model/cubit/auth_sign_in_cubit.dart';

class EmployeeInfoView extends StatefulWidget {
  const EmployeeInfoView({super.key});

  @override
  State<EmployeeInfoView> createState() => _EmployeeInfoViewState();
}

class _EmployeeInfoViewState extends State<EmployeeInfoView> {
  late final UserLocalModel? localUser;

  @override
  void initState() {
    super.initState();
    _loadLocalUser(); // استدعِ الدالة async هنا بدون await
  }

  Future<void> _loadLocalUser() async {
    final user = await HiveHelper.getUser();
    setState(() {
      localUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),

            _buildProfileField(label: 'Name', value: localUser!.name),

            _buildProfileField(
              label: 'E-mail Address',
              value: localUser!.email,
            ),

            _buildProfileField(label: 'Phone', value: localUser!.phone),

            _buildProfileField(label: 'Address', value: localUser!.address),
            _buildProfileField(label: 'Position', value: localUser!.position),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
