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
      }).catch(function (error) {
        console.log(error);
      });
    }
  });
}

function initPaginate(pages) {
  pages.forEach((page) => initPageActions(page));
}

window.addEventListener('DOMContentLoaded', () => {
  initPaginate(document.querySelectorAll('[data-paginate]'));
});