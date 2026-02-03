import { View, Text, StyleSheet, ScrollView, TouchableOpacity } from 'react-native';
import { Link } from 'expo-router';

export default function HomeScreen() {
  return (
    <ScrollView style={styles.container}>
      <View style={styles.header}>
        <View style={styles.logo}>
          <Text style={styles.logoIcon}>❤️</Text>
        </View>
        <Text style={styles.title}>MediConnect</Text>
        <Text style={styles.subtitle}>Connecting patients and doctors for better healthcare</Text>
      </View>

      <View style={styles.content}>
        <Text style={styles.sectionTitle}>Welcome to MediConnect</Text>
        <Text style={styles.description}>
          A comprehensive healthcare platform that improves communication between patients and doctors.
        </Text>

        <View style={styles.featuresContainer}>
          <View style={styles.featureCard}>
            <Text style={styles.featureIcon}>📅</Text>
            <Text style={styles.featureTitle}>Appointments</Text>
            <Text style={styles.featureDescription}>
              Schedule and manage appointments with doctors
            </Text>
          </View>

          <View style={styles.featureCard}>
            <Text style={styles.featureIcon}>💬</Text>
            <Text style={styles.featureTitle}>Messaging</Text>
            <Text style={styles.featureDescription}>
              Direct messaging with healthcare providers
            </Text>
          </View>

          <View style={styles.featureCard}>
            <Text style={styles.featureIcon}>👨‍⚕️</Text>
            <Text style={styles.featureTitle}>Doctor Profiles</Text>
            <Text style={styles.featureDescription}>
              View doctor specializations and qualifications
            </Text>
          </View>

          <View style={styles.featureCard}>
            <Text style={styles.featureIcon}>🔔</Text>
            <Text style={styles.featureTitle}>Notifications</Text>
            <Text style={styles.featureDescription}>
              Stay updated with appointment reminders
            </Text>
          </View>
        </View>

        <View style={styles.authContainer}>
          <Text style={styles.authTitle}>Get Started</Text>
          <Text style={styles.authDescription}>
            Sign in or create an account to access all features
          </Text>
          <View style={styles.buttonContainer}>
            <TouchableOpacity style={styles.primaryButton}>
              <Text style={styles.primaryButtonText}>Sign In</Text>
            </TouchableOpacity>
            <TouchableOpacity style={styles.secondaryButton}>
              <Text style={styles.secondaryButtonText}>Create Account</Text>
            </TouchableOpacity>
          </View>
        </View>

        <View style={styles.techStack}>
          <Text style={styles.techTitle}>Built With</Text>
          <View style={styles.techBadges}>
            <View style={styles.badge}>
              <Text style={styles.badgeText}>Flutter</Text>
            </View>
            <View style={styles.badge}>
              <Text style={styles.badgeText}>Firebase</Text>
            </View>
            <View style={styles.badge}>
              <Text style={styles.badgeText}>Dart</Text>
            </View>
            <View style={styles.badge}>
              <Text style={styles.badgeText}>Material Design</Text>
            </View>
          </View>
        </View>
      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5F7FA',
  },
  header: {
    alignItems: 'center',
    paddingVertical: 48,
    paddingHorizontal: 24,
    backgroundColor: '#00A0A0',
  },
  logo: {
    width: 80,
    height: 80,
    borderRadius: 16,
    backgroundColor: 'white',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 16,
  },
  logoIcon: {
    fontSize: 40,
  },
  title: {
    fontSize: 32,
    fontWeight: 'bold',
    color: 'white',
    marginBottom: 8,
  },
  subtitle: {
    fontSize: 16,
    color: 'rgba(255, 255, 255, 0.9)',
    textAlign: 'center',
  },
  content: {
    padding: 24,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#212121',
    marginBottom: 12,
  },
  description: {
    fontSize: 16,
    color: '#757575',
    lineHeight: 24,
    marginBottom: 32,
  },
  featuresContainer: {
    marginBottom: 32,
  },
  featureCard: {
    backgroundColor: 'white',
    borderRadius: 12,
    padding: 20,
    marginBottom: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  featureIcon: {
    fontSize: 40,
    marginBottom: 12,
  },
  featureTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#212121',
    marginBottom: 8,
  },
  featureDescription: {
    fontSize: 14,
    color: '#757575',
    lineHeight: 20,
  },
  authContainer: {
    backgroundColor: 'white',
    borderRadius: 12,
    padding: 24,
    marginBottom: 32,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  authTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#212121',
    marginBottom: 8,
  },
  authDescription: {
    fontSize: 14,
    color: '#757575',
    marginBottom: 20,
  },
  buttonContainer: {
    gap: 12,
  },
  primaryButton: {
    backgroundColor: '#00A0A0',
    borderRadius: 8,
    padding: 16,
    alignItems: 'center',
  },
  primaryButtonText: {
    color: 'white',
    fontSize: 16,
    fontWeight: '600',
  },
  secondaryButton: {
    backgroundColor: 'transparent',
    borderRadius: 8,
    padding: 16,
    alignItems: 'center',
    borderWidth: 2,
    borderColor: '#00A0A0',
  },
  secondaryButtonText: {
    color: '#00A0A0',
    fontSize: 16,
    fontWeight: '600',
  },
  techStack: {
    marginBottom: 32,
  },
  techTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#212121',
    marginBottom: 16,
  },
  techBadges: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 8,
  },
  badge: {
    backgroundColor: '#00A0A0',
    paddingVertical: 8,
    paddingHorizontal: 16,
    borderRadius: 20,
  },
  badgeText: {
    color: 'white',
    fontSize: 14,
    fontWeight: '500',
  },
});
