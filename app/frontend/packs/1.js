function createComment(form) {
  const commentList = document.querySelector('[data-list]');
  form.addEventListener('submit', function (e) {
    e.preventDefault();
    params = new FormData(form);
    fetch(form.action, {
      method: 'POST',
      body: params
    }).then(function (response) {
      return response.text();
    }).then(function (text) {
      commentList.innerHTML = text;
      initComment(document.querySelectorAll('[data-comment]'));
      // initLikeJs(document.querySelectorAll('[data-like-id]'));
    }).catch(function (error) {
      console.log(error);
    });
  });
}

function initComment(forms) {
  forms.forEach((form) => createComment(form));
}

window.addEventListener('DOMContentLoaded', () => {
  initComment(document.querySelectorAll('[data-comment]'));
});