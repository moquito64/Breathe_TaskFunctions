  // Initialize Firebase
  var config = {
    apiKey: "AIzaSyAtQYsEavwObn-9n_TFCmfpHNT6yBeaCNw",
    authDomain: "breathe-96720.firebaseapp.com",
    databaseURL: "https://breathe-96720.firebaseio.com",
    projectId: "breathe-96720",
    storageBucket: "breathe-96720.appspot.com",
    messagingSenderId: "762376597335"
  };
  firebase.initializeApp(config);


// Reference BreatheDatabase collection
var breatheRef = firebase.database().ref('BreatheDatabase');


// Listen for form submit
document.getElementById('contact-form').addEventListener('submit', submitForm);

// Submit form
function submitForm(e){
  e.preventDefault();
  
   // Get values
  var user = getInputVal('User');
  var olddate = getInputVal('DueDate');
  var duedate = olddate.toString();
  var oldtime = getInputVal('DueTime');
  var duetime = oldtime.toString();
  var name = getInputVal('Name');
  var completed = false;
  console.log(name, user, completed, duedate, duetime);
  // Save message
  saveTask(name, user, completed, duedate, duetime);
  
   // Show alert
  document.querySelector('.alert').style.display = 'block';

  // Hide alert after 3 seconds
  setTimeout(function(){
    document.querySelector('.alert').style.display = 'none';
  },30000);

  // Clear form
  document.getElementById('contact-form').reset();
}

// Function to get get form values
function getInputVal(id){
  return document.getElementById(id).value;
}

// Save message to firebase
function saveTask(name, user, completed, duedate, duetime){
  var newbreatheRef = breatheRef.push();
  newbreatheRef.set({
	name: name,
    addedByUser: user,
	completed: completed,
	duedate: duedate,
	duetime: duetime
  });
}

