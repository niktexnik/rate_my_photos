window.addEventListener('DOMContentLoaded', () => {
  const btnShow = document.querySelector('#show'),
    btnEdit = document.querySelector('#editPhoto'),
    btnDelete = document.querySelector('#deletePhoto'),
    photosForm = document.querySelector("#photos"),
    editForm = document.querySelector(".card shadow-sm");

  const showHandler = function (e) {

    fetch(e.target.href, {
      method: 'GET'
    }).then(function (response) {
      return response.text()
    }).then(function (text) {
      photosForm.innerHTML = text
    }).catch(function (error) {
      console.log(error)
    })
  }

  const editHandler = function (e) {

    fetch(e.target.href, {
      method: 'PATCH'
    }).then(function (response) {
      return response.text()
    }).then(function (text) {
      photosForm.innerHTML = text
    }).catch(function (error) {
      console.log(error)
    })
  }

  const deleteHandler = function (e) {

    fetch(e.target.href, {
      method: 'DELETE'
    }).then(function (response) {
      return response.text()
    }).then(function (text) {
      photosForm.innerHTML = text
    }).catch(function (error) {
      console.log(error)
    })
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

  if (btnDelete) {
    btnDelete.addEventListener('click', function (e) {
      e.preventDefault();
      deleteHandler(e);
    });
  }

});