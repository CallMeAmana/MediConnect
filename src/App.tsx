import './App.css'

function App() {
  return (
    <div className="app">
      <header className="header">
        <div className="logo">
          <div className="logo-icon">❤️</div>
        </div>
        <h1 className="title">MediConnect</h1>
        <p className="subtitle">Connecting patients and doctors for better healthcare</p>
      </header>

      <main className="content">
        <section className="welcome">
          <h2 className="section-title">Welcome to MediConnect</h2>
          <p className="description">
            A comprehensive healthcare platform that improves communication between patients and doctors through modern technology.
          </p>
        </section>

        <section className="features">
          <div className="feature-card">
            <div className="feature-icon">📅</div>
            <h3 className="feature-title">Appointments</h3>
            <p className="feature-description">
              Schedule and manage appointments with doctors. View upcoming appointments and receive timely reminders.
            </p>
          </div>

          <div className="feature-card">
            <div className="feature-icon">💬</div>
            <h3 className="feature-title">Messaging</h3>
            <p className="feature-description">
              Direct messaging with healthcare providers. Stay connected with your doctor for quick consultations.
            </p>
          </div>

          <div className="feature-card">
            <div className="feature-icon">👨‍⚕️</div>
            <h3 className="feature-title">Doctor Profiles</h3>
            <p className="feature-description">
              Browse comprehensive doctor profiles with specializations, qualifications, and experience details.
            </p>
          </div>

          <div className="feature-card">
            <div className="feature-icon">🔔</div>
            <h3 className="feature-title">Notifications</h3>
            <p className="feature-description">
              Stay updated with real-time notifications for appointments, messages, and important health reminders.
            </p>
          </div>

          <div className="feature-card">
            <div className="feature-icon">🌙</div>
            <h3 className="feature-title">Dark Mode</h3>
            <p className="feature-description">
              Comfortable viewing experience with built-in dark mode support for reduced eye strain.
            </p>
          </div>

          <div className="feature-card">
            <div className="feature-icon">🌍</div>
            <h3 className="feature-title">Multi-Language</h3>
            <p className="feature-description">
              Available in multiple languages including English, Arabic, and French for wider accessibility.
            </p>
          </div>
        </section>

        <section className="auth-section">
          <div className="auth-card">
            <h2 className="auth-title">Get Started Today</h2>
            <p className="auth-description">
              Sign in to your account or create a new one to access all features of MediConnect.
            </p>
            <div className="button-container">
              <button className="primary-button">Sign In</button>
              <button className="secondary-button">Create Account</button>
            </div>
          </div>
        </section>

        <section className="tech-stack">
          <h2 className="tech-title">Built With Modern Technology</h2>
          <div className="tech-badges">
            <span className="badge">Flutter</span>
            <span className="badge">Firebase</span>
            <span className="badge">Dart</span>
            <span className="badge">Material Design</span>
            <span className="badge">Cloud Firestore</span>
            <span className="badge">Firebase Auth</span>
          </div>
        </section>

        <section className="note">
          <div className="note-card">
            <h3>📱 Mobile App Preview</h3>
            <p>
              This is a web preview of the MediConnect mobile application.
              The actual app is built with Flutter and provides a native mobile experience
              on both iOS and Android devices with smooth animations and optimal performance.
            </p>
          </div>
        </section>
      </main>

      <footer className="footer">
        <p>© 2026 MediConnect - Healthcare Platform</p>
      </footer>
    </div>
  )
}

export default App
