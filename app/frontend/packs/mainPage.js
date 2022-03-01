function initPageActions(page) {
  const album = document.querySelector('[data-album]');
  page.addEventListener('click', function (e) {
    e.preventDefault();
    if (e.target.classList.contains("page-link")) {
      // e.target.style = "pointer-events:none;";
      fetch(e.target.href, {
        method: 'GET'
      }).then(function (response) {
        return response.text();
      }).then(function (text) {
        album.innerHTML = text;
        initPaginate(document.querySelectorAll('[data-paginate]'));
        initLikeJs(document.querySelectorAll('[data-like-id]'));
      }).catch(function (error) {
        console.log(error);
      });
    }
  });
}

function initSerach(form) {
  const album = document.querySelector('[data-album]');
  form.addEventListener('submit', function (e) {
    e.preventDefault();
    params = new URLSearchParams(new FormData(form)).toString()
    fetch(form.action + '?' + params, {
      method: 'GET'
    }).then(function (response) {
      return response.text();
    }).then(function (text) {
      album.innerHTML = text;
      initSerach(document.querySelector('[data-search]'));
      initLikeJs(document.querySelectorAll('[data-like-id]'));
    }).catch(function (error) {
      console.log(error);
    });
  });
}

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

function initPaginate(pages) {
  pages.forEach((page) => initPageActions(page));
}
function initLikeJs(nodes) {
  nodes.forEach((node) => initLikeFormActions(node));
}

window.addEventListener('DOMContentLoaded', () => {
  initPaginate(document.querySelectorAll('[data-paginate]'));
  initLikeJs(document.querySelectorAll('[data-like-id]'));
  initSerach(document.querySelector('[data-search]'));
});
