<script type="module">
  // Import the functions you need from the SDKs you need
  import { initializeApp } from "https://www.gstatic.com/firebasejs/9.9.1/firebase-app.js";
  import { getAnalytics } from "https://www.gstatic.com/firebasejs/9.9.1/firebase-analytics.js";
  // TODO: Add SDKs for Firebase products that you want to use
  // https://firebase.google.com/docs/web/setup#available-libraries

  // Your web app's Firebase configuration
  // For Firebase JS SDK v7.20.0 and later, measurementId is optional
  const firebaseConfig = {
    apiKey: "AIzaSyC6TUapFY9RDUxDdfvXd3-LkwBvoofCXmI",
    authDomain: "appdelphica.firebaseapp.com",
    projectId: "appdelphica",
    storageBucket: "appdelphica.appspot.com",
    messagingSenderId: "924330670740",
    appId: "1:924330670740:web:4e659cbe3becf4de5f9281",
    measurementId: "G-2MQE8MC9KF"
  };

  // Initialize Firebase
  const app = initializeApp(firebaseConfig);
  const analytics = getAnalytics(app);
</script>
