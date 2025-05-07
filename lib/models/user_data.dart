import 'user.dart';

class UserData {
  static List<User> dummyUsers = [
    User(
      id: '1',
      name: 'John Doe',
      email: 'patient@example.com',
      password: 'Password123!',
      type: UserType.patient,
      profileImage: 'https://images.pexels.com/photos/1516680/pexels-photo-1516680.jpeg',
    ),
    User(
      id: '2',
      name: 'Dr. Sarah Smith',
      email: 'doctor@example.com',
      password: 'Password123!',
      type: UserType.doctor,
      profileImage: 'https://images.pexels.com/photos/5452293/pexels-photo-5452293.jpeg',
      specialization: 'Cardiologist',
      qualifications: ['MBBS', 'MD', 'DM Cardiology'],
    ),
    User(
      id: '3',
      name: 'Dr. Michael Chen',
      email: 'michael@example.com',
      password: 'Password123!',
      type: UserType.doctor,
      profileImage: 'https://images.pexels.com/photos/5452201/pexels-photo-5452201.jpeg',
      specialization: 'Neurologist',
      qualifications: ['MBBS', 'MD', 'DM Neurology'],
    ),
  ];
}