// facebook snippet
(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];

  if(d.getElementById(id)) return;

  js = d.createElement(s);
  js.id = id;
  js.src = '//connect.facebook.net/en_EN/all.js#xfbml=1';
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

// twitter snippet
(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];

  if(d.getElementById(id)) return;

  js = d.createElement(s);
  js.id = id;
  js.src = 'https://platform.twitter.com/widgets.js';
  fjs.parentNode.insertBefore(js, fjs);
}(document,'script','twitter-wjs'));