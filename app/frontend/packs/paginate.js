<script>
  function initPaginate() {
  const form = document.querySelector('.album py-5 bg-light'),
  pag = document.querySelector('.pagination');
  pag.addEventListener('click', function (e) {
    e.preventDefault();
  if (e.target.classList.contains("page-link")) {
    e.target.style = "pointer-events:none;";
  fetch(e.target.href, {
    method: 'GET'
      }).then(function (response) {
        return response.text();
      }).then(function (text) {
    console.log(text);
  form.innerHTML = text;
  initPaginate();
      }).catch(function (error) {
    console.log(error);
      });
    }
  });
}

window.addEventListener('DOMContentLoaded', () => {
    initPaginate();
});
</script>