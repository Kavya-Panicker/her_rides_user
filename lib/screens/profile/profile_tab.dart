import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String firstName = 'Kavya';
  String lastName = 'Panicker';
  String phone = '+91 9737611429';
  String? email;
  String gender = 'Female';
  String? dob;
  String memberSince = 'June 2025';
  String? emergencyContact;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String? _firstNameErrorText;

  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _firstNameController.text = firstName;
    _lastNameController.text = lastName;
    if (dob != null) {
      try {
        _selectedDate = DateTime.parse(dob!);
      } catch (e) {
        _selectedDate = null;
      }
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _showEditDialog(String field, String? currentValue) {
    final TextEditingController _tempController = TextEditingController(text: currentValue ?? '');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          title: Text('Edit $field', style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
          content: TextField(
            controller: _tempController,
            decoration: InputDecoration(
              hintText: 'Enter $field',
              hintStyle: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).dividerColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {
                setState(() {
                  switch (field) {
                    case 'Phone Number':
                      phone = _tempController.text;
                      break;
                    case 'Email':
                      email = _tempController.text;
                      break;
                    case 'Gender':
                      gender = _tempController.text;
                      break;
                    case 'Date of Birth':
                      dob = _tempController.text;
                      break;
                    case 'Emergency Contact':
                      emergencyContact = _tempController.text;
                      break;
                  }
                });
                Navigator.pop(context);
              },
              child: const Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Theme.of(context).colorScheme.onPrimary,
              onSurface: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black87,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        dob = "${picked.month}/${picked.day}/${picked.year}";
      });
    }
  }

  void _showEditNameModal() {
    _firstNameController.text = firstName;
    _lastNameController.text = lastName;
    _firstNameErrorText = null;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter modalSetState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Edit Name',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.grey),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).iconTheme.color),
                        hintText: 'First Name*',
                        hintStyle: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
                        errorText: _firstNameErrorText,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Theme.of(context).dividerColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Theme.of(context).dividerColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                    ),
                    if (_firstNameErrorText != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                        child: Text(
                          _firstNameErrorText!,
                          style: const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).iconTheme.color),
                        hintText: 'Last Name',
                        hintStyle: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Theme.of(context).dividerColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Theme.of(context).dividerColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          modalSetState(() {
                            if (_firstNameController.text.isEmpty) {
                              _firstNameErrorText = 'First name cannot be empty';
                            } else {
                              _firstNameErrorText = null;
                            }
                          });

                          if (_firstNameErrorText == null) {
                            setState(() {
                              firstName = _firstNameController.text;
                              lastName = _lastNameController.text;
                            });
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Theme.of(context).colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showEditGenderModal() {
    String? tempGender = gender;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter modalSetState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Gender',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.grey),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    RadioListTile<String>(
                      title: Text('Male', style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
                      value: 'Male',
                      groupValue: tempGender,
                      onChanged: (String? value) {
                        modalSetState(() {
                          tempGender = value;
                        });
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                    RadioListTile<String>(
                      title: Text('Female', style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
                      value: 'Female',
                      groupValue: tempGender,
                      onChanged: (String? value) {
                        modalSetState(() {
                          tempGender = value;
                        });
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                    RadioListTile<String>(
                      title: Text('Other', style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
                      value: 'Other',
                      groupValue: tempGender,
                      onChanged: (String? value) {
                        modalSetState(() {
                          tempGender = value;
                        });
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            gender = tempGender ?? '';
                          });
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Theme.of(context).colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
        centerTitle: true,
        title: Text(
          'Profile',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, color: Theme.of(context).colorScheme.primary),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          _ProfileTile(
            icon: Icons.person_outline,
            title: 'Name',
            value: '$firstName $lastName',
            onTap: _showEditNameModal,
            textColor: Theme.of(context).textTheme.bodyLarge?.color,
            iconColor: Theme.of(context).iconTheme.color,
            tileColor: Theme.of(context).cardColor,
          ),
          _ProfileTile(
            icon: Icons.phone_outlined,
            title: 'Phone Number',
            value: phone,
            onTap: () => _showEditDialog('Phone Number', phone),
            textColor: Theme.of(context).textTheme.bodyLarge?.color,
            iconColor: Theme.of(context).iconTheme.color,
            tileColor: Theme.of(context).cardColor,
          ),
          _ProfileTile(
            icon: Icons.email_outlined,
            title: 'Email',
            value: email ?? 'Required',
            valueColor: email == null ? Colors.deepOrange : Theme.of(context).textTheme.bodyLarge?.color,
            requiredField: email == null,
            onTap: () => _showEditDialog('Email', email),
            textColor: Theme.of(context).textTheme.bodyLarge?.color,
            iconColor: Theme.of(context).iconTheme.color,
            tileColor: Theme.of(context).cardColor,
          ),
          _ProfileTile(
            icon: Icons.people_outline,
            title: 'Gender',
            value: gender,
            onTap: _showEditGenderModal,
            textColor: Theme.of(context).textTheme.bodyLarge?.color,
            iconColor: Theme.of(context).iconTheme.color,
            tileColor: Theme.of(context).cardColor,
          ),
          _ProfileTile(
            icon: Icons.calendar_today_outlined,
            title: 'Date of Birth',
            value: dob ?? 'Required',
            valueColor: dob == null ? Colors.deepOrange : Theme.of(context).textTheme.bodyLarge?.color,
            requiredField: dob == null,
            onTap: () => _selectDateOfBirth(context),
            textColor: Theme.of(context).textTheme.bodyLarge?.color,
            iconColor: Theme.of(context).iconTheme.color,
            tileColor: Theme.of(context).cardColor,
          ),
          _ProfileTile(
            icon: Icons.verified_user_outlined,
            title: 'Member Since',
            value: memberSince,
            enabled: false,
            textColor: Theme.of(context).textTheme.bodyLarge?.color,
            iconColor: Theme.of(context).iconTheme.color,
            tileColor: Theme.of(context).cardColor,
          ),
          _ProfileTile(
            icon: Icons.wb_sunny_outlined,
            title: 'Emergency contact',
            value: emergencyContact ?? 'Required',
            valueColor: emergencyContact == null ? Colors.deepOrange : Theme.of(context).textTheme.bodyLarge?.color,
            requiredField: emergencyContact == null,
            trailing: emergencyContact == null
                ? GestureDetector(
                    onTap: () => _showEditDialog('Emergency Contact', emergencyContact),
                    child: Text('Add', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600)),
                  )
                : null,
            onTap: () => _showEditDialog('Emergency Contact', emergencyContact),
            textColor: Theme.of(context).textTheme.bodyLarge?.color,
            iconColor: Theme.of(context).iconTheme.color,
            tileColor: Theme.of(context).cardColor,
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color? valueColor;
  final bool requiredField;
  final bool enabled;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? textColor;
  final Color? iconColor;
  final Color? tileColor;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.value,
    this.valueColor,
    this.requiredField = false,
    this.enabled = true,
    this.onTap,
    this.trailing,
    this.textColor,
    this.iconColor,
    this.tileColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: tileColor ?? Theme.of(context).cardColor,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: iconColor ?? Theme.of(context).iconTheme.color),
        title: Text(
          title,
          style: TextStyle(
            color: textColor ?? Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: trailing ??
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).iconTheme.color,
              size: 16,
            ),
        onTap: enabled ? onTap : null,
        subtitle: Text(
          value,
          style: TextStyle(color: valueColor ?? Theme.of(context).textTheme.bodyMedium?.color),
        ),
      ),
    );
  }
} 