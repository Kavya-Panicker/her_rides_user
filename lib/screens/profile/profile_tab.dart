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
          backgroundColor: Theme.of(context).cardColor,
          title: Text('Edit $field', style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
          content: TextField(
            controller: _editController,
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
                setState(() {
                  isEditing = false;
                  editingField = null;
                });
              },
              child: Text('Cancel', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
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
            value: name,
            onTap: () => _showEditDialog('Name', name),
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
            onTap: () => _showEditDialog('Gender', gender),
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
            onTap: () => _showEditDialog('Date of Birth', dob),
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