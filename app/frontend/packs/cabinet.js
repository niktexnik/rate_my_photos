window.addEventListener('DOMContentLoaded', () => {
  const btnShow = document.querySelector('#show'),
    btnAdd = document.querySelector('#add'),
    btnEdit = document.querySelector('#editPhoto'),
    btnDelete = document.querySelector('#deletePhoto'),
    photosForm = document.querySelector("#photos"),
    editForm = document.querySelector(".card shadow-sm");
  
  function showHandler(e) {
    fetch(e.target.href, {
      method: 'GET'
    }).then(function (response) {
      return response.text();
    }).then(function (text) {
      photosForm.innerHTML = text;
    }).catch(function (error) {
      console.log(error);
    });
  }

  function addHandler(e) {
    openModal();
    fetch(e.target.href, {
      method: 'GET'
    }).then(function (response) {
      return response.text();
    }).then(function (text) {
      modalContent.innerHTML = text;
    }).catch(function (error) {
      console.log(error);
    });
  }
  
  function editHandler(e) {
    openModal();
    fetch(e.target.href, {
      method: 'GET'
    }).then(function (response) {
      return response.text();
    }).then(function (text) {
      photosForm.innerHTML = text;
    }).catch(function (error) {
      console.log(error);
    });
  }
  
  function deleteHandler(e) {
  
    fetch(e.target.href, {
      method: 'DELETE'
    }).then(function (response) {
      return response.text();
    }).then(function (text) {
      photosForm.innerHTML = text;
    }).catch(function (error) {
      console.log(error);
    });
  }
  
  if (btnShow) {
    btnShow.addEventListener('click', function (e) {
      e.preventDefault();
      showHandler(e);
    });
  }
  
  if (btnEdit) {
    btnEdit.addEventListener('click', function (e) {
      e.preventDefault();
      editHandler(e);
    });
  }

  if (btnAdd) {
    btnAdd.addEventListener('click', function (e) {
      e.preventDefault();
      addHandler(e);
    });
  }
  
  if (btnDelete) {
    btnDelete.addEventListener('click', function (e) {
      e.preventDefault();
      deleteHandler(e);
    });
  }
  
});