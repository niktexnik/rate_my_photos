
function initJs(nodes) {

  nodes.forEach((node) => {
    const btnLike = node.querySelector('#btnLike');
    const btnUnlike = node.querySelector('#btnUnlike');

    if (btnLike) {
      btnLike.addEventListener('click', function (e) {
        e.preventDefault();
        likeHandler(e);
      });
    }

    if (btnUnlike) {
      btnUnlike.addEventListener('click', function (e) {
        e.preventDefault();
        unlikeHandler(e);
      });
    }
  });

  function unlikeHandler(e) {
    e.target.style = "pointer-events:none;";
    fetch(e.target.href, {
      method: 'DELETE'
    }).then(function (response) {
      return response.text();
    }).then(function (text) {
      forms.innerHTML = text;
      console.log(forms)
      initJs(forms);
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
      forms.innerHTML = text;
      console.log(forms)
      initJs(forms);
    }).catch(function (error) {
      console.log(error);
    });
  }
}

window.addEventListener('DOMContentLoaded', () => {
  forms = document.querySelectorAll("#likeForm");
  initJs(forms);
});