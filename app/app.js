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

// Tutor List
const tutors = [
  { id: 'tutor1', name: 'John Doe' },
  { id: 'tutor2', name: 'Jane Smith' },
  { id: 'tutor3', name: 'Ali Reza' }
];

app.get("/Users-formatted", function(req, res) {
  var sql = 'select * from User';
  db.query(sql).then(results => {
        // Send the results rows to the all-students template
        // The rows will be in a variable called data
      res.render('User', {data: results});
  });
});



// Home route - renders the main selection page
app.get('/', (req, res) => {
  res.render('index', { title: 'Welcome to Connect 4', tutors });
});

// Route for selecting a tutor
app.post('/select', (req, res) => {
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

