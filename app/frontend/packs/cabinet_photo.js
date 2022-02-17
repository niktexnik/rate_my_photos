function initPhotoFormActions(form) {
  console.log("initPhotoFormActions")

  //photo
  const btnEdit = form.querySelector('#editPhoto');
  const btnDelete = form.querySelector('#deletePhoto');
  const btnView = form.querySelector('#showPhoto');
  const photosForm = document.querySelector("#photos");
  const editForm = document.querySelector(".card shadow-sm");
  //modal
  const modal = document.querySelector('.modal');
  const modalContent = document.querySelector('.content');
  const modalCloseBtn = document.querySelector('[data-close]');


  if (btnView) {
    btnView.addEventListener('click', function (e) {

      e.preventDefault();
      openModal()
      e.target.disabled = true;
      fetch(e.target.form.action, {
        method: 'POST'
      }).then(function (response) {
        return response.text();
      }).then(function (text) {
        modalContent.innerHTML = text;
        initPhotoFormActions(form);
      }).catch(function (error) {
        console.log(error);
      });
    });
  }

  if (btnDelete) {
    btnDelete.addEventListener('click', function (e) {

      e.preventDefault();
      e.target.style = "pointer-events:none;";
      fetch(e.target.href, {
        method: 'DELETE'
      }).then(function (response) {
        return response.text();
      }).then(function (text) {
        photosForm.innerHTML = text;
        initPhotoFormActions(form);
      }).catch(function (error) {
        console.log(error);
      });
    });
  }

  if (btnEdit) {
    btnEdit.addEventListener('click', function (e) {
      
      e.preventDefault();
      e.target.style = "pointer-events:none;";
      fetch(e.target.href, {
        method: 'PUT'
      }).then(function (response) {
        return response.text();
      }).then(function (text) {
        editForm.innerHTML = text;
        initPhotoFormActions(form);
      }).catch(function (error) {
        console.log(error);
      });
    });
  }

  function closeModal() {
    modal.classList.add('hide');
    modal.classList.remove('show');
    document.body.style.overflow = '';
  }
  
  function openModal() {
    modal.classList.add('show');
    modal.classList.remove('hide');
    document.body.style.overflow = 'hidden';
  }

  if (modalCloseBtn) {
    modalCloseBtn.addEventListener('click', closeModal);
  }
  if(modal){
    modal.addEventListener('click', (e) => {
    if (e.target === modal) {
      closeModal();
    }
    });
  }

  document.addEventListener('keydown', (e) => {
    if (e.code === "Escape" && modal.classList.contains('show')) {
      closeModal();
    }
  });
}

function initJs(nodes) {
  nodes.forEach((node) => initPhotoFormActions(node));
}

window.addEventListener('DOMContentLoaded', () => {
  btnsPhoto = document.querySelectorAll(".btn-group");
  console.log("btnsPhoto", btnsPhoto)
  initJs(btnsPhoto);
});