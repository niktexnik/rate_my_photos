window.addEventListener('DOMContentLoaded', () => {
  //cabinet
  const cabinetBtns = document.querySelector('#cabinetBtns');
  const album = document.querySelector("[data-album]");
  const keyPlace = document.querySelector("#key");
  //photo
  const btnSave = document.querySelector('#savePhoto');
  const btnBackToCabinet = document.querySelector('#backToCabinet');
  
  // // //modal
  const modal = document.querySelector('.modal');
  const modalContent = modal.querySelector('.content');
  const modalCloseBtn = modal.querySelector('[data-close]');

  //cabinet 

  cabinetBtns.addEventListener('click', function (e) {
    e.preventDefault();
    if (e.target.id === "addPhoto") {
      addPhotoHandler(e)
    } else if (e.target.id === "editProfile") {
      editProfileHandler(e)
    } else if (e.target.id === "showPhotos") {
      showPhotosHandler(e)
    } else if (e.target.id === "getKey") {
      getKeyHandler(e)
    }
  });

  function showPhotosHandler(e) {
    fetch(e.target.href, {
      method: 'GET'
    }).then(function (response) {
      return response.text();
    }).then(function (text) {
      album.innerHTML = text;
      initPaginate(document.querySelectorAll('[data-paginate]'));
      initAlbumJs(document.querySelectorAll('[data-cards]'));
      initSerach(document.querySelector('[data-search]'));
    }).catch(function (error) {
      console.log(error);
    });
  }

  function getKeyHandler(e) {
    fetch(e.target.href, {
      method: 'PUT'
    }).then(function (response) {
      return response.text();
    }).then(function (text) {
      keyPlace.innerHTML = text;
    }).catch(function (error) {
      console.log(error);
    });
  }

  function editProfileHandler(e) {
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


  function addPhotoHandler(e) {
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

  function initPhotoFormActions(card) {

    //photo
    const btnEdit = card.querySelector('#editPhoto');
    const btnDelete = card.querySelector('#deletePhoto');
    const btnView = card.querySelector('#viewPhoto');

    if (btnView) {
      btnView.addEventListener('click', function (e) {
        e.preventDefault();
        openModal()
        e.target.disabled = true;
        fetch(e.target.href, {
          method: 'GET'
        }).then(function (response) {
          return response.text();
        }).then(function (text) {
          modalContent.innerHTML = text;
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
          album.innerHTML = text;
        }).catch(function (error) {
          console.log(error);
        });
      });
    }

    if (btnEdit) {
      btnEdit.addEventListener('click', function (e) {
        openModal()
        e.preventDefault();
        e.target.style = "pointer-events:none;";
        fetch(e.target.href, {
          method: 'GET'
        }).then(function (response) {
          return response.text();
        }).then(function (text) {
          modalContent.innerHTML = text;
        }).catch(function (error) {
          console.log(error);
        });
      });
    }
  }

  function initAlbumJs(cards) {
    cards.forEach((card) => initPhotoFormActions(card));
  }

  //==============PAGINATION====================================
  function initPageActions(page) {
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
          initAlbumJs(document.querySelectorAll('[data-cards]'));
        }).catch(function (error) {
          console.log(error);
        });
      }
    });
  }
  
  function initPaginate(pages) {
    pages.forEach((page) => initPageActions(page));
  }
  //=================SEARCH===============================
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
        initAlbumJs(document.querySelectorAll('[data-cards]'));
        initPaginate(document.querySelectorAll('[data-paginate]'));
      }).catch(function (error) {
        console.log(error);
      });
    });
  }
  //=================MODAL================================
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
  if (modal) {
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

});