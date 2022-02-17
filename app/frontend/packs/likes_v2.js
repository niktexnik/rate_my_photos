function initLikeFormActions(form) {

  const btnLike = form.querySelector('#btnLike');
  const btnUnlike = form.querySelector('#btnUnlike');

  if (btnLike) {
    btnLike.addEventListener('click', function (e) {

      e.preventDefault();
      e.target.disabled = true;
      fetch(e.target.form.action, {
        method: 'POST'
      }).then(function (response) {
        return response.text();
      }).then(function (text) {
        form.innerHTML = text;
        initLikeFormActions(form);
      }).catch(function (error) {
        console.log(error);
      });
    });
  }

  if (btnUnlike) {
    btnUnlike.addEventListener('click', function (e) {

      e.preventDefault();
      e.target.style = "pointer-events:none;";
      fetch(e.target.href, {
        method: 'DELETE'
      }).then(function (response) {
        return response.text();
      }).then(function (text) {
        form.innerHTML = text;
        initLikeFormActions(form);
      }).catch(function (error) {
        console.log(error);
      });
    });
  }
}

function initJs(nodes) {
  nodes.forEach((node) => initLikeFormActions(node));
}

window.addEventListener('DOMContentLoaded', () => {
  forms = document.querySelectorAll("#likeForm");
  initJs(forms);
});