const initJs = function () {
  console.log('initJs ready...');
  const btnLike = document.querySelectorAll('#btnLike'),
    btnUnlike = document.querySelectorAll('#btnUnlike'),
    likeForm = document.querySelector("#likeForm");

  console.dir(btnLike)
  console.dir(btnUnlike)


  function unlikeHandler(e) {
    e.target.style = "pointer-events:none;";
    fetch(e.target.href, {
      method: 'DELETE'
    }).then(function (response) {
      return response.text();
    }).then(function (text) {
      likeForm.innerHTML = text;
      initJs()
    }).catch(function (error) {
      console.log(error);
    });
  }

  function likeHandler(e) {
    e.target.disabled = true;
    fetch(e.target.form.action, {
      method: 'POST'
    }).then(function (response) {
      return response.text();
    }).then(function (text) {
      likeForm.innerHTML = text;
      initJs()
    }).catch(function (error) {
      console.log(error)
    });
  }

  if (btnLike) {
    btnLike.forEach(btn => {
      btn.addEventListener('click', function (e) {
        e.preventDefault();
        likeHandler(e);
      });
    });
  }

  if (btnUnlike) {
    btnUnlike.forEach(btn => {
      btn.addEventListener('click', function (e) {
        e.preventDefault();
        unlikeHandler(e);
      });
    });
  }
};

window.addEventListener('DOMContentLoaded', () => {
  initJs();
});