import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String name = 'Kavya Panicker';
  String phone = '+91 9737611429';
  String? email;
  String gender = 'Female';
  String? dob;
  String memberSince = 'June 2025';
  String? emergencyContact;

  bool isEditing = false;
  String? editingField;
  final TextEditingController _editController = TextEditingController();

  void _startEdit(String field, String? currentValue) {
    setState(() {
      editingField = field;
      isEditing = true;
      _editController.text = currentValue ?? '';
    });
  }

  void _saveEdit() {
    setState(() {
      switch (editingField) {
        case 'Name':
          name = _editController.text;
          break;
        case 'Phone Number':
          phone = _editController.text;
          break;
        case 'Email':
          email = _editController.text;
          break;
        case 'Gender':
          gender = _editController.text;
          break;
        case 'Date of Birth':
          dob = _editController.text;
          break;
        case 'Emergency Contact':
          emergencyContact = _editController.text;
          break;
      }
      isEditing = false;
      editingField = null;
      _editController.clear();
    });
  }

  void _showEditDialog(String field, String? currentValue) {
    _startEdit(field, currentValue);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $field'),
          content: TextField(
            controller: _editController,
            decoration: InputDecoration(hintText: 'Enter $field'),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  isEditing = false;
                  editingField = null;
                });
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE91E63),
              ),
              onPressed: () {
                _saveEdit();
                Navigator.pop(context);
              },
              child: const Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Color(0xFFE91E63)),
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
            value: name,
            onTap: () => _showEditDialog('Name', name),
          ),
          _ProfileTile(
            icon: Icons.phone_outlined,
            title: 'Phone Number',
            value: phone,
            onTap: () => _showEditDialog('Phone Number', phone),
          ),
          _ProfileTile(
            icon: Icons.email_outlined,
            title: 'Email',
            value: email ?? 'Required',
            valueColor: email == null ? Colors.deepOrange : Colors.black,
            requiredField: email == null,
            onTap: () => _showEditDialog('Email', email),
          ),
          _ProfileTile(
            icon: Icons.people_outline,
            title: 'Gender',
            value: gender,
            onTap: () => _showEditDialog('Gender', gender),
          ),
          _ProfileTile(
            icon: Icons.calendar_today_outlined,
            title: 'Date of Birth',
            value: dob ?? 'Required',
            valueColor: dob == null ? Colors.deepOrange : Colors.black,
            requiredField: dob == null,
            onTap: () => _showEditDialog('Date of Birth', dob),
          ),
          _ProfileTile(
            icon: Icons.verified_user_outlined,
            title: 'Member Since',
            value: memberSince,
            enabled: false,
          ),
          _ProfileTile(
            icon: Icons.wb_sunny_outlined,
            title: 'Emergency contact',
            value: emergencyContact ?? 'Required',
            valueColor: emergencyContact == null ? Colors.deepOrange : Colors.black,
            requiredField: emergencyContact == null,
            trailing: emergencyContact == null
                ? GestureDetector(
                    onTap: () => _showEditDialog('Emergency Contact', emergencyContact),
                    child: const Text('Add', style: TextStyle(color: Color(0xFF1976D2), fontWeight: FontWeight.w600)),
                  )
                : null,
            onTap: () => _showEditDialog('Emergency Contact', emergencyContact),
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

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.value,
    this.valueColor,
    this.requiredField = false,
    this.enabled = true,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          enabled: enabled,
          onTap: enabled ? onTap : null,
          leading: Icon(icon, color: const Color(0xFFE91E63)),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          subtitle: Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  color: valueColor ?? Colors.black,
                  fontWeight: valueColor != null ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
              if (requiredField && value == 'Required')
                const SizedBox(width: 4),
              if (trailing != null) trailing!,
            ],
          ),
          trailing: enabled ? const Icon(Icons.chevron_right) : null,
        ),
        const Divider(height: 1),
      ],
    );
  }
} 