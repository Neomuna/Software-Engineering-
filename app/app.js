// app.js 
const express = require('express');
const db = require('./services/db');
const path = require('path');

const app = express();
const port = 3000;

// Set up Pug as the templating engine
app.set('view engine', 'pug');
app.set('views', path.join(__dirname, 'views'));

// Serve static assets (CSS, images, etc.)
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.urlencoded({ extended: true }));

// Hard coded tutor List
const tutors = [
  { id: 'tutor1', name: 'John Doe' },
  { id: 'tutor2', name: 'Jane Smith' },
  { id: 'tutor3', name: 'Ali Reza' }
];

app.get("/Language-formatted", function(req, res) {
  var sql = 'select * from language';
  db.query(sql).then(results => {
        // Send the results rows to the all-students template
        // The rows will be in a variable called data
      res.render('langauge', {data: results});
  });
});

// functio to check login
function isAuthenticated(req, res, next) {
  if (req.session.user) return next();
  res.redirect('/login');
}

// GET: Login Page
app.get('/login', (req, res) => {
  res.render('login');
});

// POST: Handle Login
app.post('/login', (req, res) => {
  const { username, password } = req.body;
  const sql = 'SELECT * FROM User WHERE Username = ? AND Password = ?';
  db.query(sql, [username, password]).then(results => {
    if (results.length > 0) {
      req.session.user = results[0];
      res.redirect('/');
    } else {
      res.send('Invalid credentials. <a href="/login">Try again</a>');
    }
  }).catch(err => {
    console.error('Login error:', err);
    res.send('An error occurred. Please try again.');
  });
});

// GET: Logout
app.get('/logout', (req, res) => {
  req.session.destroy(() => {
    res.redirect('/login');
  });
});

app.get("/User-formatted", function(req, res) {
  var sql = 'select * from user';
  db.query(sql).then(results => {
        // Send the results rows to the all-students template
        // The rows will be in a variable called data
      res.render('user', {data: results});
  });
});


// Home route - renders the main selection page
app.get('/', (req, res) => {
  var sql = 'select * from language';
  db.query(sql).then(results => {
        // Send the results rows to the all-students template
        // The rows will be in a variable called data
      res.render('index', {languages: results, title: 'Welcome to Connect 4', tutors});
  });
});


// for login 
const session = require('express-session');

app.use(session({
  secret: 'connect4_secret_key',
  resave: false,
  saveUninitialized: false
}))

app.post('/login', (req, res) => {
  const { username, password } = req.body;

  const sql = 'SELECT * FROM User WHERE Username = ? AND Password = ?';
  db.query(sql, [username, password]).then(results => {
    if (results.length > 0) {
      // Found user!
      req.session.user = results[0]; // You can store the whole user or just essentials
      res.redirect('/');
    } else {
      res.send('Invalid credentials. <a href="/login">Try again</a>');
    }
  }).catch(err => {
    console.error('Login error:', err);
    res.send('An error occurred. Please try again.');
  });
});

// Route for selecting a tutor
app.post('/select', (req, res) => {
  console.log(req.body); // Added new line
  const { language, tutor } = req.body;
 
  // Find the selected tutor by ID
  const selectedTutor = tutors.find(t => t.id === tutor);

  res.render('booking-page', { language, tutor: selectedTutor });
});

// Route for confirming booking
app.post('/book', (req, res) => {
  const { language, tutor, date, time } = req.body;

  // Find the selected tutor again
  const selectedTutor = tutors.find(t => t.id === tutor);

  res.render('booking-confirmation', {
    language,
    tutor: selectedTutor,
    date,
    time
  });
});

// Start server
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});